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
-- My own functions
require("functions")

--}}}
--{{{ Variables

    modmask = "Mod4"
       term = "urxvtc"
    browser = "firefox"
filemanager = "thunar"
 theme_path = awful.util.getdir("config").."/themes/lightblue"

if theme_path ~= nil then
    beautiful.init(theme_path)
else
    beautiful.init("/usr/share/awesome/themes/default/theme")
end

layouts             = { awful.layout.suit.vile
                      , awful.layout.suit.vile.bottom
                      , awful.layout.suit.max
                      , awful.layout.suit.fair
                      , awful.layout.suit.magnifier
                      , awful.layout.suit.floating
                      }

-- Apps that should be forced floating
floatapps           = { ["MPlayer"] = true
                      ,    ["Gimp"] = true
                      ,     ["vlc"] = true
                      -- ,  ["Mirage"] = true
                      }

-- Apps that should always appear on a certain tag
apptags             = {   ["Firefox"] = { screen = 1, tag = 2 }
                      ,      ["Gimp"] = { screen = 1, tag = 6 }
                      , ["Mplayer.*"] = { screen = 1, tag = 5 }
                      }

--}}}
--{{{ Tags

tag_properties = { { name = "1-main"
                   , layout = layouts[1] }
                 , { name = "2-www"
                   , layout = layouts[3]
                   , nmaster = 1 }
                 , { name = "3-dev"
                   , layout = layouts[1]
                   , mwfact = 0.618033988769
                   , ncols = 2 }
                 , { name = "4-misc"
                   , layout = layouts[6] }
                 , { name = "5-media"
                   , layout = layouts[3]
                   , nmaster = 0 }
                 , { name = "6"
                   , layout = layouts[6] }
                 , { name = "7"
                   , layout = layouts[1] }
                 , { name = "8"
                   , layout = layouts[6] }
                 , { name = "9"
                   , layout = layouts[5] }
                 }

for s = 1, screen.count() do
    tags[s] = { }
    for i, v in ipairs(tag_properties) do
        tags[s][i] = tag(v.name)
        tags[s][i].screen = s
        awful.tag.setproperty(tags[s][i], "layout", v.layout)
        awful.tag.setproperty(tags[s][i], "mwfact", v.mwfact)
        awful.tag.setproperty(tags[s][i], "nmaster", v.nmaster)
        awful.tag.setproperty(tags[s][i], "ncols", v.ncols)
    end
    tags[s][1].selected = true
end

--}}}
--{{{ Menu
-- Submenu
awesomemenu         = { { "Edit config", term.." -e vim "..awful.util.getdir("config").."/rc.lua" }
                      , {     "Restart", awesome.restart }
                      , {        "Quit", awesome.quit }
                      }
-- Mainmenu
mainmenu            = awful.menu.new({ items = { { "Terminal", term }
                                               , {  "Firefox", browser }
                                               , {   "Thunar", filemanager }
                                               , {     "Gimp", "gimp" }
                                               , {   "Screen", term.." -e screen -RR" }
                                               , {     "Mocp", term.." -e mocp" }
                                               , {  "Awesome", awesomemenu }
                                               }
                                     })

--}}}
--{{{ Widgets
-- Please note the functions feeding some of the widgets are found in functions.lua

-- Simple spacer we can use to cleaner code
spacer = " "
spacerwidget_widgetzone = widget({ type = "textbox", align = "right" })
spacerwidget_widgetzone.text = set_focus_foreground("-")
spacerwidget_taglist = widget({ type = "textbox", align = "left" })
spacerwidget_taglist.text = spacer

-- Create the clock widget
clockwidget = widget({ type = "textbox", align = "right" })
-- Run it once so we don't have to wait for the hooks to see our clock
clock_info("%d/%m/%Y", "%H:%M")

-- Create the mocp widget
mocwidget = widget({ type = "textbox", align = "right" })
-- Detailed song info
mocwidget.mouse_enter = function ()
    local songsrc = io.popen("mocp -Q %song")
    local song = string.gsub(songsrc:read(), "^%d*", "")
    songsrc:close()
    song = string.gsub(song, "%(.*", "")
    local artistsrc = io.popen("mocp -Q %artist")
    local artist = artistsrc:read()
    artistsrc:close()
    local albumsrc = io.popen("mocp -Q %album")
    local album = albumsrc:read()
    albumsrc:close()
    local ctsrc = io.popen("mocp -Q %ct")
    local ct = ctsrc:read()
    ctsrc:close()
    local ttsrc = io.popen("mocp -Q %tt")
    local tt = ttsrc:read()
    ttsrc:close()
    moc_detailedinfo = naughty.notify({ text = set_focus_foreground("Song:")..spacer..song.."\n"..
                                               set_focus_foreground("Artist:")..spacer..artist.."\n"..
                                               set_focus_foreground("Album:")..spacer..album.."\n"..
                                               set_focus_foreground("Elapsed:")..spacer..ct.."/"..tt
                                       , timeout = 0
                                       , hover_timeout = 0.5
                                       , width = 250
                                       })
end
mocwidget.mouse_leave = function () naughty.destroy(moc_detailedinfo) end
-- Run it once so we don't have to wait for the hooks to see our song
moc_info()

-- Create the battery widget
batterywidget = widget({ type = "textbox", align = "right" })
-- Run it once so we don't have to wait for the hooks to see our percentage
battery_info("BAT1")

-- Create a system tray
systray = widget({ type = "systray", align = "right" })

-- Initialize which buttons do what when clicking the taglist
taglist.buttons     = { button({ }          , 1, awful.tag.viewonly)
                      , button({ modmask }  , 1, awful.client.movetotag)
                      , button({ }          , 3, function (tag) tag.selected = not tag.selected end)
                      , button({ modmask }  , 3, awful.client.toggletag)
                      , button({ }          , 4, awful.tag.viewnext)
                      , button({ }          , 5, awful.tag.viewprev) 
                      }
-- Initialize which buttons do what when clicking the tasklist
tasklist.buttons    = { button({ }          , 1, function (c) client.focus = c; c:raise() end)
                      , button({ }          , 3, function () awful.menu.clients({ width=250 }) end)
                      , button({ }          , 4, function () awful.client.focus.byidx(1) end)
                      , button({ }          , 5, function () awful.client.focus.byidx(-1) end) 
                      }

-- From here on, everything gets created for every screen
for s = 1, screen.count() do
    -- Promptbox (pops up with mod+r)
    promptbox[s] = widget({ type = "textbox", align = "left" })
    -- Layouticon for the current tag
    layoutbox[s] = widget({ type = "imagebox", align = "left" })
    layoutbox[s]:buttons({ button({ }       , 1, function () awful.layout.inc(layouts, 1) end)
                         , button({ }       , 3, function () awful.layout.inc(layouts, -1) end)
                         , button({ }       , 4, function () awful.layout.inc(layouts, 1) end)
                         , button({ }       , 5, function () awful.layout.inc(layouts, -1) end)
                         })
    -- Create the taglist
    taglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, taglist.buttons)
    -- Create the tasklist
    tasklist[s] = awful.widget.tasklist.new(function(c)
                                                --[[if c == client.focus and c ~= nil then 
                                                    return set_focus_foreground(c.name)
                                                end]]
                                                return awful.widget.tasklist.label.currenttags(c, s)
                                            end, tasklist.buttons)
 
    -- Finally, create the statusbar (called wibox), and set its properties
    statusbar[s] = wibox({ position = "top"
                         , height = "16"
                         , fg = beautiful.fg_normal
                         , bg = beautiful.bg_normal
                         -- , border_color = beautiful.border_normal
                         -- , border_width = beautiful.border_width 
                         })
    -- Add our widgets to the wibox
    statusbar[s].widgets = { layoutbox[s]
                           , spacerwidget_taglist
                           , taglist[s]
                           , tasklist[s]
                           , promptbox[s]
                           , mocwidget
                           , spacerwidget_widgetzone
                           , batterywidget
                           , spacerwidget_widgetzone
                           , clockwidget
                           , s == 1 and systray or nil
                           }
    -- Add it to each screen
    statusbar[s].screen = s
end

--}}}
--{{{ Bindings

root.buttons({
    button({ }                                        , 3         , function () mainmenu:toggle() end),
    button({ }                                        , 4         , awful.tag.viewnext),
    button({ }                                        , 5         , awful.tag.viewprev)
})

key_list = { "#10", "#11", "#12", "#13", "#14", "#15", "#16", "#17", "#18" }
keynumber = 9
for i = 1, keynumber do
    table.insert(globalkeys,
        key({ modmask }, key_list[i],
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewonly(tags[screen][i])
                end
            end))
    table.insert(globalkeys,
        key({ modmask, "Control" }, key_list[i],
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    tags[screen][i].selected = not tags[screen][i].selected
                end
            end))
    table.insert(globalkeys,
        key({ modmask, "Shift" }, key_list[i],
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.movetotag(tags[client.focus.screen][i])
                end
            end))
    table.insert(globalkeys,
        key({ modmask, "Control", "Shift" }, key_list[i],
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.toggletag(tags[client.focus.screen][i])
                end
            end))
end

-- These should be straightforward...
table.insert(globalkeys, key({ modmask }              , "Left"    , awful.tag.viewprev))
table.insert(globalkeys, key({ modmask }              , "Right"   , awful.tag.viewnext))
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
table.insert(globalkeys, key({ modmask, "Shift" }     , "h"       , function () awful.tag.incnmaster(1) end))
table.insert(globalkeys, key({ modmask, "Shift" }     , "l"       , function () awful.tag.incnmaster(-1) end))
table.insert(globalkeys, key({ modmask, "Control" }   , "h"       , function () awful.tag.incncol(1) end))
table.insert(globalkeys, key({ modmask, "Control" }   , "l"       , function () awful.tag.incncol(-1) end))
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

    -- Check if the application should be floating
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

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
    if layout and beautiful["layout_"..layout] then
        layoutbox[screen].image = image(beautiful["layout_"..layout])
    else
        layoutbox[screen].image = nil
    end
    
    -- Give focus to the latest client in history if no window has focus
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)

---- Timed hooks for the widget functions
-- 1 minute
awful.hooks.timer.register(60, function ()
    clock_info("%d/%m/%Y", "%H:%M")
end)

-- 10 seconds
awful.hooks.timer.register(10, function()
    moc_info()
end)

-- 30 seconds
awful.hooks.timer.register(20, function()
    battery_info("BAT1")
end)

--}}}
