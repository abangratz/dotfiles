-------------------------------------------------------------------------------
--
-- Battery widget for Awesome 3.5
-- Copyright (C) 2011-2016 Tuomas Jormola <tj@solitudo.net>
--
-- Licensed under the terms of GNU General Public License Version 2.0.
--
-- Description:
--
-- Shows a battery status indicator. Battery level is indicated as
-- a vertical progress bar and an icon indicator is shown next to it.
-- Clicking the icon launches an external application (if configured).
--
-- Widget extends vicious.widgets.bat from Vicious widget framework.
--
-- Widget tries to use icons from the package gnome-icon-theme
-- if available.
--
-- This widget uses Lua BitOp http://bitop.luajit.org.
--
--
-- Configuration:
--
-- The load() function can be supplied with configuration.
-- Format of the configuration is as follows.
-- {
-- -- Name of the battery. Matches a file under the directory
-- -- /sys/class/power_supply/ and typically is "BATn" where n
-- -- is a number, most likely 0. 'BAT0' by default.
--        battery            = 'BAT2',
-- -- Command to execute when left-clicking the widget icon.
-- -- Empty by default.
--        command            = 'gnome-power-preferences',
-- -- Don't try to display any icons. Default is false (i.e. display icons).
--        no_icon            = true,
-- -- Height of the progress bar in pixels. Default is 19.
--        progressbar_height = 19,
-- -- Width of the progress bar in pixels. Default is 12.
--        progressbar_width  = 12,
-- -- How often update the widget data. Default is 20 seconds.
--        update_interval    = 30
-- }
--
--
-- Theme:
--
-- The widget uses following settings, colors and icons if available in
-- the Awesome theme.
--
-- theme.progressbar_height                  - height of the battery charge progress bar in pixels
-- theme.progressbar_width                   - width of the battery charge progress bar in pixels
-- theme.bg_widget                           - widget background color
-- theme.fg_widget                           - widget foreground color
-- theme.fg_center_widget                    - widget gradient color, middle
-- theme.fg_end_widget                       - widget gradient color, end
-- theme.delightful_battery_full             - icon shown when the battery has full charge and discharging
-- theme.delightful_battery_full_charging    - icon shown when the battery has full charge and charging
-- theme.delightful_battery_good             - icon shown when the battery has 30%-99% charge left and discharging
-- theme.delightful_battery_good_charging    - icon shown when the battery has 30%-99% charge left and charging
-- theme.delightful_battery_low              - icon shown when the battery has 10%-29% charge left and discharging
-- theme.delightful_battery_low_charging     - icon shown when the battery has 10%-29% charge left and charging
-- theme.delightful_battery_caution          - icon shown when the battery has 1%-9% charge left and discharging
-- theme.delightful_battery_caution_charging - icon shown when the battery has 1%-9% charge left and charging
-- theme.delightful_battery_empty            - icon shown when the battery has less than 1% charge left
-- theme.delightful_battery_unknown          - icon shown when battery status is unknown
-- theme.delightful_error                    - icon shown when critical error has occurred
--
-------------------------------------------------------------------------------

local awful      = require('awful')
local wibox      = require('wibox')
local beautiful  = require('beautiful')

local delightful = { utils = require('delightful.utils') }
local vicious    = require('vicious')

local bit        = require('bit')

local pairs  = pairs
local string = { format = string.format, sub = string.sub }

module('delightful.widgets.battery')

local battery_config
local fatal_error
local icon_tooltip
local icon_files        = {}
local icon
local prev_icon

local config_description = {
    {
        name     = 'battery',
        required = true,
        default  = 'BAT0',
        validate = function(value)
            local status, errors = delightful.utils.config_string(value)
            if not status then
                return status, errors
            end
            local battery_path = string.format('/sys/class/power_supply/%s/status', value)
            if not awful.util.file_readable(battery_path) then
                return false, string.format('Battery not found: %s', value)
            end
            return true
        end
    },
    {
        name     = 'command',
        default  = 'gnome-power-preferences',
        validate = function(value) return delightful.utils.config_string(value) end
    },
    {
        name     = 'no_icon',
        validate = function(value) return delightful.utils.config_boolean(value) end
    },
    {
        name     = 'progressbar_height',
        required = true,
        default  = 19,
        validate = function(value) return delightful.utils.config_int(value) end
    },
    {
        name     = 'progressbar_width',
        required = true,
        default  = 12,
        validate = function(value) return delightful.utils.config_int(value) end
    },
    {
        name     = 'update_interval',
        required = true,
        default  = 20,
        validate = function(value) return delightful.utils.config_int(value) end
    },
}

local icon_description = {
    battery_full_charging    = { beautiful_name = 'delightful_battery_full_charging',    default_icon = 'battery-full-charging'    },
    battery_full             = { beautiful_name = 'delightful_battery_full',             default_icon = 'battery-full'             },
    battery_good_charging    = { beautiful_name = 'delightful_battery_good_charging',    default_icon = 'battery-good-charging'    },
    battery_good             = { beautiful_name = 'delightful_battery_good',             default_icon = 'battery-good'             },
    battery_low_charging     = { beautiful_name = 'delightful_battery_low_charging',     default_icon = 'battery-low-charging'     },
    battery_low              = { beautiful_name = 'delightful_battery_low',              default_icon = 'battery-low'              },
    battery_caution_charging = { beautiful_name = 'delightful_battery_caution_charging', default_icon = 'battery-caution-charging' },
    battery_caution          = { beautiful_name = 'delightful_battery_caution',          default_icon = 'battery-caution'          },
    battery_empty            = { beautiful_name = 'delightful_battery_empty',            default_icon = 'battery-empty'            },
    battery_unknown          = { beautiful_name = 'delightful_battery_unknown',          default_icon = 'battery-missing'          },
    error                    = { beautiful_name = 'delightful_error',                    default_icon = 'dialog-error'             },
}

local UNKNOWN, CHARGING, DISCHARGING, EMPTY, CAUTION, LOW, GOOD, FULL = 1, 2, 3, 4, 5, 6, 7, 8

local mask = {
    UNKNOWN     = 1,
    CHARGING    = bit.lshift(1, 1),
    DISCHARGING = bit.lshift(1, 2),
    EMPTY       = bit.lshift(1, 3),
    CAUTION     = bit.lshift(1, 4),
    LOW         = bit.lshift(1, 5),
    GOOD        = bit.lshift(1, 6),
    FULL        = bit.lshift(1, 7),
}

local capacity_limit = {
    GOOD    = 100,
    LOW     = 30,
    CAUTION = 10,
    EMPTY   = 1,
}

local icon_mapping = {}
icon_mapping[bit.bor(mask.FULL,        mask.FULL)   ] = function() return icon_files and icon_files.battery_full             end
icon_mapping[bit.bor(mask.CHARGING,    mask.FULL)   ] = function() return icon_files and icon_files.battery_full_charging    end
icon_mapping[bit.bor(mask.DISCHARGING, mask.FULL)   ] = function() return icon_files and icon_files.battery_full             end
icon_mapping[bit.bor(mask.UNKNOWN,     mask.FULL)   ] = function() return icon_files and icon_files.battery_full             end
icon_mapping[                          mask.FULL    ] = function() return icon_files and icon_files.battery_full             end
icon_mapping[bit.bor(mask.CHARGING,    mask.GOOD)   ] = function() return icon_files and icon_files.battery_good_charging    end
icon_mapping[bit.bor(mask.DISCHARGING, mask.GOOD)   ] = function() return icon_files and icon_files.battery_good             end
icon_mapping[bit.bor(mask.UNKNOWN,     mask.GOOD)   ] = function() return icon_files and icon_files.battery_good             end
icon_mapping[                          mask.GOOD    ] = function() return icon_files and icon_files.battery_good             end
icon_mapping[bit.bor(mask.CHARGING,    mask.LOW)    ] = function() return icon_files and icon_files.battery_low_charging     end
icon_mapping[bit.bor(mask.DISCHARGING, mask.LOW)    ] = function() return icon_files and icon_files.battery_low              end
icon_mapping[bit.bor(mask.UNKNOWN,     mask.LOW)    ] = function() return icon_files and icon_files.battery_low              end
icon_mapping[                          mask.LOW     ] = function() return icon_files and icon_files.battery_low              end
icon_mapping[bit.bor(mask.CHARGING,    mask.CAUTION)] = function() return icon_files and icon_files.battery_caution_charging end
icon_mapping[bit.bor(mask.DISCHARGING, mask.CAUTION)] = function() return icon_files and icon_files.battery_caution          end
icon_mapping[bit.bor(mask.UNKNOWN,     mask.CAUTION)] = function() return icon_files and icon_files.battery_caution          end
icon_mapping[                          mask.CAUTION ] = function() return icon_files and icon_files.battery_caution          end
icon_mapping[bit.bor(mask.CHARGING,    mask.EMPTY)  ] = function() return icon_files and icon_files.battery_empty            end
icon_mapping[bit.bor(mask.DISCHARGING, mask.EMPTY)  ] = function() return icon_files and icon_files.battery_empty            end
icon_mapping[bit.bor(mask.UNKNOWN,     mask.EMPTY)  ] = function() return icon_files and icon_files.battery_empty            end
icon_mapping[                          mask.EMPTY   ] = function() return icon_files and icon_files.battery_empty            end
icon_mapping[bit.bor(mask.CHARGING,    mask.UNKNOWN)] = function() return icon_files and icon_files.battery_unknown          end
icon_mapping[bit.bor(mask.DISCHARGING, mask.UNKNOWN)] = function() return icon_files and icon_files.battery_unknown          end
icon_mapping[                          mask.UNKNOWN ] = function() return icon_files and icon_files.battery_unknown          end

local state_mapping = {}
state_mapping['⌁'] = mask.UNKNOWN
state_mapping['↯'] = mask.FULL
state_mapping['+'] = mask.CHARGING
state_mapping['−'] = mask.DISCHARGING

-- Configuration handler
function handle_config(user_config)
    local empty_config = delightful.utils.get_empty_config(config_description)
    if not user_config then
        user_config = empty_config
    end
    local config_data = delightful.utils.normalize_config(user_config, config_description)
    local validation_errors = delightful.utils.validate_config(config_data, config_description)
    if validation_errors then
        fatal_error = 'Configuration errors: \n'
        for error_index, error_entry in pairs(validation_errors) do
            fatal_error = string.format('%s %s', fatal_error, error_entry)
            if error_index < #validation_errors then
                fatal_error = string.format('%s \n', fatal_error)
            end
        end
        battery_config = empty_config
        return
    end
    battery_config = config_data
end

-- Initalization
function load(self, config)
    handle_config(config)
    if fatal_error then
        delightful.utils.print_error('battery', fatal_error)
        return nil, nil
    end
    if not battery_config.no_icon then
        icon_files = delightful.utils.find_icon_files(icon_description)
    end
    if icon_files.battery_full and icon_files.battery_good_charging and icon_files.battery_good and icon_files.battery_low_charging and icon_files.battery_low and icon_files.battery_caution_charging and icon_files.battery_caution and icon_files.battery_empty and icon_files.battery_unknown and icon_files.error then
        local buttons = awful.button({}, 1, function()
                if not fatal_error and battery_config.command then
                    awful.util.spawn(battery_config.command, true)
                end
        end)
        icon = wibox.widget.imagebox()
        icon:buttons(buttons)
        icon_tooltip = awful.tooltip({ objects = { icon } })
    end

    local bg_color        = delightful.utils.find_theme_color({ 'bg_widget', 'bg_normal'                     })
    local fg_color        = delightful.utils.find_theme_color({ 'fg_widget', 'fg_normal'                     })
    local fg_center_color = delightful.utils.find_theme_color({ 'fg_center_widget', 'fg_widget', 'fg_normal' })
    local fg_end_color    = delightful.utils.find_theme_color({ 'fg_end_widget', 'fg_widget', 'fg_normal'    })

    local battery_widget = awful.widget.progressbar()
    if bg_color then
        battery_widget:set_border_color(bg_color)
        battery_widget:set_background_color(bg_color)
    end
    local color_args = fg_color
    local height = beautiful.progressbar_height or battery_config.progressbar_height
    local width  = beautiful.progressbar_width  or battery_config.progressbar_width
    if fg_color and fg_center_color and fg_end_color then
        color_args = {
            type = 'linear',
            from = { width / 2, 0 },
            to = { width / 2, height },
            stops = {{ 0, fg_end_color }, { 0.5, fg_center_color }, { 1, fg_color }},
        }
    end
    battery_widget:set_color(color_args)
    battery_widget:set_width(width)
    battery_widget:set_height(height)
    battery_widget:set_vertical(true)
    vicious.register(battery_widget, vicious.widgets.bat, vicious_formatter, battery_config.update_interval, battery_config.battery)

    return { battery_widget }, { icon }
end

-- Vicious display formatter, also update widget tooltip and icon
function vicious_formatter(widget, data)
    local mask_state = mask.DISCHARGING, mask_capacity
    if data[1] and state_mapping[data[1]] then
        mask_state = state_mapping[data[1]]
    end
    if data[2] then
        if data[2] < capacity_limit.EMPTY then
            mask_capacity = mask.EMPTY
        elseif data[2] < capacity_limit.CAUTION then
            mask_capacity = mask.CAUTION
        elseif data[2] < capacity_limit.LOW then
            mask_capacity = mask.LOW
        elseif data[2] < capacity_limit.GOOD then
            mask_capacity = mask.GOOD
        else
            mask_capacity = mask.FULL
        end
    end
    -- this is sometimes incorrectly rounded down to negative
    if data[3] and string.sub(data[3], 1, 1) == '-' then
        data[3] = '00:00'
    end
    local mask_combined = mask.UNKNOWN
    if mask_capacity then
        if mask_state then
            if mask_capacity == mask.FULL and mask_state == mask.FULL then
                mask_state = mask.CHARGING
            end
            mask_combined = bit.bor(mask_state, mask_capacity)
        else
            mask_combined = mask_capacity
        end
    end
    -- update tooltip
    if icon_tooltip then
        local tooltip_text
        if not bit.band(mask_combined, mask.UNKNOWN) == 0 then
            tooltip_text = 'Battery status is unknown'
        elseif mask_capacity then
            tooltip_text = string.format('Battery charge %d%%', data[2])
            if bit.band(mask_state, mask.CHARGING) ~= 0 then
                tooltip_text = string.format('%s \n On AC power', tooltip_text)
                if data[3] and (data[3] ~= 'N/A' and data[3] ~= '00:00') then
                    tooltip_text = string.format('%s, %s until charged', tooltip_text, data[3])
                end
            elseif bit.band(mask_state, mask.DISCHARGING) ~= 0 then
                tooltip_text = string.format('%s \n On battery power', tooltip_text)
                if data[3] and data[3] ~= 'N/A' then
                    tooltip_text = string.format('%s, %s left', tooltip_text, data[3])
                end
            end
        else
            fatal_error = 'Failed to update battery status'
        end
        if fatal_error then
            tooltip_text = fatal_error
        end
        icon_tooltip:set_text(string.format(' %s ', tooltip_text))
    end
    -- update icon
    if icon then
        local icon_file
        if not fatal_error and icon_mapping[mask_combined] then
            icon_file = icon_mapping[mask_combined]()
            if not icon_file then
                fatal_error = 'Failed to update battery icon: No icon file found'
            end
        else
            fatal_error = string.format('Failed to update battery icon: No icon mapping found for mask %s|%s = %s',
                (mask_state or 'nil'), (mask_capacity or 'nil'), (mask_combined or 'nil'))
        end
        if fatal_error then
            icon_file = icon_files.error
            if icon_tooltip then
                icon_tooltip:set_text(string.format(' %s ', fatal_error))
            end
        end
        if icon_file and (not prev_icon or prev_icon ~= icon_file) then
            prev_icon = icon_file
            icon:set_image(icon_file)
        end
    end
    if fatal_error then
        return 0
    else
        return data[2]
    end
end
