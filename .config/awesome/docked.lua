local n = require('naughty')

local lscreens = {}
for s in screen do
  for name, _ in pairs(s.outputs) do
    n.notify({text=name})
    lscreens[name] = s
  end
end
for _, c in ipairs(client.get()) do
  n.notify({text=c.name})
  if string.match(c.name, "emacs") then
    c:move_to_screen(lscreens["DP-1-3-1"])
    c:move_to_tag(lscreens["DP-1-3-1"].tags[1])
  end
  if string.match(c.name, "Google Chrome") then
    if string.match(c.name, "spacemacs/layers") then
      n.notify({text=c.name})
      c:move_to_screen(lscreens["HDMI-1-1"])
      c:move_to_tag(lscreens["HDMI-1-1"].tags[4])
    elseif(string.match(c.name, "YouTube")) then
      c:move_to_screen(lscreens["HDMI-1-1"])
      c:move_to_tag(lscreens["HDMI-1-1"].tags[3])
    else
      c:move_to_screen(lscreens["DP-1-3-1"])
      c:move_to_tag(lscreens["DP-1-3-1"].tags[2])
    end
  end
  if string.match(c.name, "Mozilla Firefox") then
    if string.match(c.name, "YouTube") then
      c:move_to_screen(lscreens["HDMI-1-1"])
      c:move_to_tag(lscreens["HDMI-1-1"].tags[6])
    else
      c:move_to_screen(lscreens["DP-1-3-1"])
      c:move_to_tag(lscreens["DP-1-3-1"].tags[4])
    end
  end
  if string.match(c.name, "Teams") then
    c:move_to_screen(lscreens["DP-1-3-1"])
    c:move_to_tag(lscreens["DP-1-3-1"].tags[5])
  end
  if string.match(c.name, "byobu") then
    c:move_to_screen(lscreens["DP-1-3-1"])
    c:move_to_tag(lscreens["DP-1-3-1"].tags[3])
  end
  if string.match(c.name, "Zoom") then
    c:move_to_screen(lscreens["DP-1-3-1"])
    c:move_to_tag(lscreens["DP-1-3-1"].tags[6])
  end
  if string.match(c.name, "Terminal") then
    c:move_to_screen(lscreens["DP-1-3-1"])
    c:move_to_tag(lscreens["DP-1-3-1"].tags[2])
  end
  if string.match(c.name, "| Platogo") then
    c:move_to_screen(lscreens["HDMI-1-1"])
    c:move_to_tag(lscreens["HDMI-1-1"].tags[1])
  end
  if string.match(c.name, "Discord") then
    c:move_to_screen(lscreens["HDMI-1-1"])
    c:move_to_tag(lscreens["HDMI-1-1"].tags[1])
  end
  if string.match(c.name, "Signal") then
    c:move_to_screen(lscreens["HDMI-1-1"])
    c:move_to_tag(lscreens["HDMI-1-1"].tags[6])
  end
  if string.match(c.name, "Telegram") then
    c:move_to_screen(lscreens["HDMI-1-1"])
    c:move_to_tag(lscreens["HDMI-1-1"].tags[7])
  end
end
