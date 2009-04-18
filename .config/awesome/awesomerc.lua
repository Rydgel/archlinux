-- awesome 3 (git) configuration file by Gigamo <gigamo[at]gmail[dot]com>
io.stderr:write("\n\r::: Awesome loaded at ", os.date("%d/%m/%Y %T"), " :::\r\n\n")
--{{{ Create tables

      tags = { }
 statusbar = { }
 promptbox = { }
   taglist = { }
  tasklist = { }
 layoutbox = { }
globalkeys = { }
clientkeys = { }

--}}}
--{{{ Imports

-- Standard awesome libraries
require("awful")
require("beautiful")
-- Notification library
require("naughty")
-- Other
require("shifty")
-- My own functions
require("functions")

--}}}
--{{{ Variable definitions

    modmask = "Mod4"
       term = "urxvt"
    browser = "firefox"
filemanager = "thunar"
 theme_path = awful.util.getdir("config").."/themes/raziel"

if theme_path ~= nil then
    beautiful.init(theme_path)
else
    beautiful.init("/usr/share/awesome/themes/default/theme")
end

      local tile = awful.layout.suit.tile
  local tileleft = awful.layout.suit.tile.left
local tilebottom = awful.layout.suit.tile.bottom
   local tiletop = awful.layout.suit.tile.top
       local max = awful.layout.suit.max
local fullscreen = awful.layout.suit.max.fullscreen
     local fairv = awful.layout.suit.fair
     local fairh = awful.layout.suit.fair.horizontal
 local magnifier = awful.layout.suit.magnifier
  local floating = awful.layout.suit.floating

layouts   = { tile
            -- , tileleft
            , tilebottom
            -- , tiletop
            , max
            -- , fullscreen
            , fairv
            -- , fairh
            , magnifier
            , floating
            }

--}}}
--{{{ Shifty

shifty.config.tags = {   ["1:main"] = { layout = tile
                                      , init = true
                                      , position = 1
                                      , screen = 1
                                      -- , spawn = term
                                      , mwfact = 0.618033988769
                                      , nmaster = 2
                                      }
                     ,    ["2:www"] = { layout = max
                                      , exclusive = true
                                      , solitary = true
                                      , position = 2
                                      , spawn = browser
                                      }
                     ,    ["3:dev"] = { layout = tile
                                      , position = 3
                                      }
                     ,   ["4:misc"] = { layout = floating
                                      , position = 4
                                      , leave_kills = true
                                      }
                     ,["5:office"]  = { layout = tile
                                      , position = 5
                                      , leave_kills = true
                                      }
                     ,["6:deluge"]  = { layout = tile
                                      , position = 6
                                      , leave_kills = true
                                      }
                     ,["evolution"] = { layout = max
                                      , rel_index = 3
                                      , leave_kills = true
                                      }
                     ,     ["gimp"] = { layout = floating
                                      , mwfact = 0.18
                                      , leave_kills = true
                                      }
                     ,      ["gui"] = { layout = tile
                                      , rel_index = 1
                                      , leave_kills = true
                                      }
                     ,    ["media"] = { layout = floating
                                      , rel_index = 0
                                      , leave_kills = true
                                      }
                     ,   ["pidgin"] = { layout = floating
                                      , rel_index = 2
                                      , leave_kills = true
                                      }
                     , ["_console"] = { layout = magnifier
                                      , position = 9
                                      , exclusive = true
                                      , solitary = true
                                      }
                     }

shifty.config.apps = { { match = { "Firefox", "Midori", "Minefield", "Navigator", "Opera" }, tag = "2:www" }
                     , { match = { "Gimp" }, tag = "gimp", intrusive = true }
                     , { match = { "gimp-image-window" }, slave = true, float = true }
                     , { match = { "Thunar", "Nautilus" }, tag = "gui" }
                     , { match = { "Pidgin"}, tag = "pidgin", float = true }
                     , { match = { "MPlayer.*", "Mirage"}, tag = "media", nopopup = true, float = false }
                     , { match = { "Evolution"}, tag = "evolution" }
                     , { match = { "xterm" }, tag = "_console", intrusive = true }
                     , { match = { "rxvt-unicode.*", "urxvt" }, intrusive = true }
                     , { match = { "Deluge", "deluge*" }, tag = "6:deluge", intrusive = true}
                     }

shifty.config.defaults = { floatBars = true
                         , run = function(tag)
                               naughty.notify({ text = set_focus_foreground("Shifty Created: ")..shifty.tag2index(tag)..": "..tag.name })
                           end
                         }

--}}}
--{{{ Widgets
-- Please note the functions feeding some of the widgets are found in functions.lua
spacer = " "
layoutseparator = widget({ type = "imagebox" })
layoutseparator.image = image(awful.util.getdir("config").."/icons/sep1.png")
widgetseparator = widget({ type = "imagebox", align = "right" })
widgetseparator.image = image(awful.util.getdir("config").."/icons/sep1.png")

-- Create the clock widget
clockwidget = widget({ type = "textbox", align = "right" })
clock_info("%d/%m/%Y", "%H:%M")

-- Create the battery progressbar widget
batbarwidget = widget({ type = "progressbar", align = "right" })
batbarwidget.width          = 9
batbarwidget.height         = 1
batbarwidget.gap            = 0
batbarwidget.border_padding = 1
batbarwidget.border_width   = 1
batbarwidget.ticks_count    = 4
batbarwidget.vertical       = true
batbarwidget:bar_properties_set("bat", { bg           = beautiful.bg_normal
                                       , fg           = "#CC9393"
                                       , fg_center    = "#F0EFD0"
                                       , fg_end       = "#7F9F7F"
                                       , border_color = beautiful.border_focus
                                       , min_value    = 0
                                       , max_value    = 100
                                       })
battery_info("BAT1", "progressbar")
-- Mouseover bat pb
batbarwidget.mouse_enter = function ()
    bat_detailedinfo = naughty.notify({ text = battery_info("BAT1", "popup")
                                      , timeout = 0
                                      , hover_timeout = 0.5
                                      , width = 150
                                      })
end
batbarwidget.mouse_leave = function () naughty.destroy(bat_detailedinfo) end

-- Create the memory progressbar widget
membarwidget = widget({ type = "progressbar", align = "right" })
membarwidget.width          = 9
membarwidget.height         = 1
membarwidget.gap            = 0
membarwidget.border_padding = 1
membarwidget.border_width   = 1
membarwidget.ticks_count    = 4
membarwidget.vertical       = true
membarwidget:bar_properties_set("mem", { bg           = beautiful.bg_normal
                                       , fg           = "#7F9F7F"
                                       , fg_center    = "#F0EFD0"
                                       , fg_end       = "#CC9393"
                                       , border_color = beautiful.border_focus
                                       , min_value    = 0
                                       , max_value    = 100 
                                       })
mem_info("progressbar")
-- Mouseover mem pb
membarwidget.mouse_enter = function ()
    mem_detailedinfo = naughty.notify({ text = mem_info("popup")
                                      , timeout = 0
                                      , hover_timeout = 0.5
                                      , width = 100
                                      })
end
membarwidget.mouse_leave = function () naughty.destroy(mem_detailedinfo) end

-- Create a system tray
systray = widget({ type = "systray", align = "right" })

taglist.buttons     = { button({ }          , 1, awful.tag.viewonly)
                      , button({ modmask }  , 1, awful.client.movetotag)
                      , button({ }          , 3, function (tag) tag.selected = not tag.selected end)
                      , button({ modmask }  , 3, awful.client.toggletag)
                      , button({ }          , 4, awful.tag.viewnext)
                      , button({ }          , 5, awful.tag.viewprev) 
                      }
tasklist.buttons    = { button({ }          , 1, function (c) client.focus = c; c:raise() end)
                      , button({ }          , 3, function () awful.menu.clients({ width=250 }) end)
                      , button({ }          , 4, function () awful.client.focus.byidx(1) end)
                      , button({ }          , 5, function () awful.client.focus.byidx(-1) end) 
                      }

for s = 1, screen.count() do
    promptbox[s] = widget({ type = "textbox", align = "left" })
    layoutbox[s] = widget({ type = "textbox", align = "left" })
    layoutbox[s]:buttons({ button({ }       , 1, function () awful.layout.inc(layouts, 1) end)
                         , button({ }       , 3, function () awful.layout.inc(layouts, -1) end)
                         , button({ }       , 4, function () awful.layout.inc(layouts, 1) end)
                         , button({ }       , 5, function () awful.layout.inc(layouts, -1) end)
                         })
    taglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, taglist.buttons)
    tasklist[s] = awful.widget.tasklist.new(function(c)
                                                if c == client.focus and c ~= nil then 
                                                    return spacer..set_focus_foreground(c.name)
                                                end
                                                -- return awful.widget.tasklist.label.currenttags(c, s)
                                            end, tasklist.buttons)
 
    statusbar[s] = wibox({ position = "top"
                         , height = "16"
                         , fg = beautiful.fg_normal
                         , bg = beautiful.bg_normal
                         -- , border_color = beautiful.border_normal
                         -- , border_width = beautiful.border_width 
                         })

    statusbar[s].widgets = { taglist[s]
                           , tasklist[s]
                           , layoutseparator
                           , layoutbox[s]
                           , layoutseparator
                           , promptbox[s]
                           , widgetseparator
                           , clockwidget
                           , membarwidget
                           , batbarwidget
                           , s == 1 and systray or nil
                           }
    statusbar[s].screen = s

    statusbar[s] = wibox({ position = "bottom"
                         , height = "16"
                         , fg = beautiful.fg_normal
                         , bg = "#00000000"
                         -- , border_color = beautiful.border_normal
                         -- , border_width = beautiful.border_width 
                         })
   statusbar[s].screen = s

end

-- Shifty's taglist + initialize shifty
shifty.taglist = taglist
shifty.init()

--}}}
--{{{ Bindings

root.buttons({
    button({ }                                        , 4         , awful.tag.viewnext),
    button({ }                                        , 5         , awful.tag.viewprev)
})

key_list = { "#10", "#11", "#12", "#13", "#14", "#15", "#16", "#17", "#18" }
keynumber = 9
for i = 1, keynumber do
    table.insert(globalkeys,
        key({ modmask }, key_list[i],
            function () local t = shifty.getpos(i, true) end))
    table.insert(globalkeys,
        key({ modmask, "Control" }, key_list[i],
            function () local t = shifty.getpos(i); t.selected = not t.selected end))
    table.insert(globalkeys,
        key({ modmask, "Shift" }, key_list[i],
            function () if client.focus then awful.client.movetotag(shifty.getpos(i, true)) end end))
    table.insert(globalkeys,
        key({ modmask, "Control", "Shift" }, key_list[i],
            function () if client.focus then awful.client.toggletag(shifty.getpos(i)) end end))
end

-- Shifty
table.insert(globalkeys, key({ modmask }              , "Left"    , shifty.prev))
table.insert(globalkeys, key({ modmask }              , "Right"   , shifty.next))
table.insert(globalkeys, key({ modmask, "Control" }   , "Left"    , shifty.shift_prev))
table.insert(globalkeys, key({ modmask, "Control" }   , "Right"   , shifty.shift_next))
table.insert(globalkeys, key({ modmask, "Shift" }     , "Left"    , shifty.send_prev))
table.insert(globalkeys, key({ modmask, "Shift" }     , "Right"   , shifty.send_next))
table.insert(globalkeys, key({ modmask }              , "F1"      , shifty.del))
table.insert(globalkeys, key({ modmask }              , "F2"      , shifty.rename))
table.insert(globalkeys, key({ modmask }              , "F3"      , shifty.add))
table.insert(globalkeys, key({ modmask }              , "F4"      , function() shifty.add({ nopopup = true }) end))

-- These should be straightforward...
table.insert(globalkeys, key({ modmask }              , "x"       , function () awful.util.spawn(term) end))
table.insert(globalkeys, key({ modmask }              , "f"       , function () awful.util.spawn(browser) end))
table.insert(globalkeys, key({ modmask }              , "t"       , function () awful.util.spawn(filemanager) end))
table.insert(globalkeys, key({ modmask, "Control" }   , "r"       , function () promptbox[mouse.screen].text = awful.util.escape(awful.util.restart()) end))
table.insert(globalkeys, key({ modmask, "Shift" }     , "q"       , awesome.quit))
table.insert(globalkeys, key({ modmask }              , "m"       , awful.client.maximize))
table.insert(globalkeys, key({ modmask }              , "c"       , function () client.focus:kill() end))
table.insert(globalkeys, key({ modmask }              , "j"       , function () awful.client.focus.byidx(1); client.focus:raise() end))
table.insert(globalkeys, key({ modmask }              , "k"       , function () awful.client.focus.byidx(-1);  client.focus:raise() end))
table.insert(globalkeys, key({ modmask, "Control" }   , "space"   , awful.client.togglefloating))
table.insert(globalkeys, key({ modmask, "Control" }   , "Return"  , function () client.focus:swap(awful.client.master()) end))
table.insert(globalkeys, 
    key({ modmask }, "Tab", 
        function ()
            local allclients = awful.client.visible(client.focus.screen)
            for i,v in ipairs(allclients) do
                if allclients[i+1] then
                    allclients[i+1]:swap(v)
                end
            end
            awful.client.focus.byidx(-1)
        end))
table.insert(globalkeys, key({ modmask }              , "u"       , awful.client.urgent.jumpto))
table.insert(globalkeys, key({ modmask, "Shift" }     , "r"       , function () client.focus:redraw() end))
table.insert(globalkeys, key({ modmask }              , "l"       , function () awful.tag.incmwfact(0.025) end))
table.insert(globalkeys, key({ modmask }              , "h"       , function () awful.tag.incmwfact(-0.025) end))
-- Change slave client height
table.insert(globalkeys, key({ modmask, "Shift" }     , "h"       , function () awful.client.incwfact(0.05) end))
table.insert(globalkeys, key({ modmask, "Shift" }     , "l"       , function () awful.client.incwfact(-0.05) end))
table.insert(globalkeys, key({ modmask, "Control" }   , "h"       , function () awful.tag.incnmaster(1) end))
table.insert(globalkeys, key({ modmask, "Control" }   , "l"       , function () awful.tag.incnmaster(-1) end))
table.insert(globalkeys, key({ modmask }              , "space"   , function () awful.layout.inc(layouts, 1) end))
table.insert(globalkeys, key({ modmask, "Shift" }     , "space"   , function () awful.layout.inc(layouts, -1) end))
table.insert(globalkeys, key({ modmask }              , "r"       , function () awful.prompt.run({ prompt = set_focus_foreground(spacer.."Run:"..spacer) }, promptbox[mouse.screen], awful.util.spawn, awful.completion.bash, awful.util.getdir("cache").."/history") end))
table.insert(globalkeys, key({ }                      , "#121"    , function () awful.util.spawn("dvol -t") end))
table.insert(globalkeys, key({ }                      , "#122"    , function () awful.util.spawn("dvol -d 2") end))
table.insert(globalkeys, key({ }                      , "#123"    , function () awful.util.spawn("dvol -i 2") end))
table.insert(clientkeys, key({ modmask, "Control" }   , "space"   , awful.client.floating.toggle))

-- Set keys
root.keys(globalkeys)

--}}}
--{{{ Hooks

-- Gets executed when focusing a client
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Gets executed when unfocusing a client
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Gets executed when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Gets executed when unmarking a client
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Gets executed when the mouse enters a client
awful.hooks.mouse_enter.register(function (c)
    if awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Gets executed when a new client appears
awful.hooks.manage.register(function (c)
    if not startup and awful.client.focus.filter(c) then
        c.screen = mouse.screen
    end

    -- Add mouse binds
    c:buttons({ button({ }           , 1     , function (c) client.focus = c; c:raise() end)
              , button({ modmask }   , 1     , awful.mouse.client.move)
              , button({ modmask }   , 3     , awful.mouse.client.resize)
              })

    -- Set border anyway
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    client.focus = c

    -- Set key bindings
    c:keys(clientkeys)

    -- Prevent new clients from becoming master
    awful.client.setslave(c)

    -- Inogre size hints usually given out by terminals (prevent gaps between windows)
    c.size_hints_honor = false

    awful.placement.no_overlap(c)
    awful.placement.no_offscreen(c)
end)

-- Gets exeucted when arranging the screen (as in, tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    -- Update the layoutbox image
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout then
        layoutbox[screen].text = spacer..set_focus_foreground(layout)..spacer
    else
        layoutbox[screen].text = nil
    end
    
    -- Give focus to the latest client in history if no window has focus
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)

---- Timed hooks for widget functions
-- 1 minute
awful.hooks.timer.register(60, function ()
    clock_info("%d/%m/%Y", "%H:%M")
end)

-- 20 seconds
awful.hooks.timer.register(20, function()
    battery_info("BAT1", "progressbar")
    mem_info("progressbar")
end)

--}}}
