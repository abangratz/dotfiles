-------------------------------------------------------------------------------
--
-- CPU widget for Awesome 3.5
-- Copyright (C) 2011-2016 Tuomas Jormola <tj@solitudo.net>
--
-- Licensed under the terms of GNU General Public License Version 2.0.
--
-- Description:
--
-- Displays horizontal usage trend graph of all the CPUs combined.
-- Also displays a CPU icon next to the graph. Clicking the icon
-- launches an external application (if configured).
--
-- Widget extends vicious.widgets.cpu from Vicious widget framework.
--
-- Widget tries to use an icon from the package mate-sensors-applet-common
-- if available.
--
--
-- Configuration:
--
-- The load() function can be supplied with configuration.
-- Format of the configuration is as follows.
-- {
-- -- Command to execute when left-clicking the widget icon.
-- -- Empty by default.
--        command         = 'gnome-system-monitor',
-- -- Don't try to display any icons. Default is false (i.e. display icons).
--        no_icon         = true,
-- -- Height of the graph in pixels. Default is 19.
--        graph_height    = 19,
-- -- Width of the graph in pixels. Default is 30.
--        graph_width     = 50,
-- -- How often update the widget data. Default is 1 second.
--        update_interval = 2
-- }
--
--
-- Theme:
--
-- The widget uses following settings, colors and icons if available in
-- the Awesome theme.
--
-- theme.graph_height     - height of the CPU graph in pixels
-- theme.graph_width      - width of the CPU graph in pixels
-- theme.bg_widget        - widget background color
-- theme.fg_widget        - widget foreground color
-- theme.fg_center_widget - widget gradient color, middle
-- theme.fg_end_widget    - widget gradient color, end
-- theme.delightful_cpu   - icon shown next to the CPU graph
---
-------------------------------------------------------------------------------

local awful       = require('awful')
local wibox       = require('wibox')
local beautiful   = require('beautiful')

local delightful  = { utils = require('delightful.utils') }
local vicious     = require('vicious')

local pairs  = pairs
local string = { format = string.format }

module('delightful.widgets.cpu')

local cpu_config
local fatal_error
local icon_tooltip

local config_description = {
    {
        name     = 'command',
        validate = function(value) return delightful.utils.config_string(value) end
    },
    {
        name     = 'no_icon',
        validate = function(value) return delightful.utils.config_boolean(value) end
    },
    {
        name     = 'graph_height',
        required = true,
        default  = 19,
        validate = function(value) return delightful.utils.config_int(value) end
    },
    {
        name     = 'graph_width',
        required = true,
        default  = 30,
        validate = function(value) return delightful.utils.config_int(value) end
    },
    {
        name     = 'update_interval',
        required = true,
        default  = 1,
        validate = function(value) return delightful.utils.config_int(value) end
    },
}

local icon_description = {
    cpu = { beautiful_name = 'delightful_cpu', default_icon = 'mate-sensors-applet-cpu' },
}

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
        cpu_config = empty_config
        return
    end
    cpu_config = config_data
end

-- Initalization
function load(self, config)
    handle_config(config)
    if fatal_error then
        delightful.utils.print_error('cpu', fatal_error)
        return nil, nil
    end
    local icon
    local icon_files
    if not cpu_config.no_icon then
        icon_files = delightful.utils.find_icon_files(icon_description)
    end
    local icon_file = icon_files and icon_files.cpu
    if icon_file then
        local buttons = awful.button({}, 1, function()
            if not fatal_error and cpu_config.command then
                awful.util.spawn(cpu_config.command, true)
            end
        end)
        icon = wibox.widget.imagebox()
        icon:buttons(buttons)
        icon:set_image(icon_file)
        icon_tooltip = awful.tooltip({ objects = { icon } })
    end

    local bg_color        = delightful.utils.find_theme_color({ 'bg_widget', 'bg_normal'                     })
    local fg_color        = delightful.utils.find_theme_color({ 'fg_widget', 'fg_normal'                     })
    local fg_center_color = delightful.utils.find_theme_color({ 'fg_center_widget', 'fg_widget', 'fg_normal' })
    local fg_end_color    = delightful.utils.find_theme_color({ 'fg_end_widget', 'fg_widget', 'fg_normal'    })

    local cpu_widget = awful.widget.graph()
    if bg_color then
        cpu_widget:set_background_color(bg_color)
        cpu_widget:set_border_color(bg_color)
    end
    local color_args = fg_color
    local height = beautiful.graph_height or cpu_config.graph_height
    local width  = beautiful.graph_width  or cpu_config.graph_width
    if fg_color and fg_center_color and fg_end_color then
        color_args = {
            type = 'linear',
            from = { width / 2, 0 },
            to = { width / 2, height },
            stops = {{ 0, fg_end_color }, { 0.5, fg_center_color }, { 1, fg_color }},
        }
    end
    cpu_widget:set_color(color_args)
    cpu_widget:set_width(width)
    cpu_widget:set_height(height)
    local w = wibox.layout.fixed.horizontal()
    w:add(cpu_widget)
    vicious.register(cpu_widget, vicious.widgets.cpu, vicious_formatter, cpu_config.update_interval)

    return { w }, { icon }
end

-- Vicious display formatter, also update widget tooltip
function vicious_formatter(widget, data)
    if icon_tooltip then
        local tooltip_text = string.format(' CPU usage trend graph of all the CPUs in the system \n Current CPU usage: %d%% ', data[1])
        icon_tooltip:set_text(tooltip_text)
    end
    return data[1]
end
