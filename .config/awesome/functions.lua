---- Markup functions
function set_background(bgcolor, text)
    if text ~= nil then
        return '<bg color="'..bgcolor..'" />'..text
    end
end

function set_foreground(fgcolor, text)
    if text ~= nil then
        return '<span color="'..fgcolor..'">'..text..'</span>'
    end
end

function set_focus_foreground(text)
    if text ~= nil then
        return set_foreground(beautiful.fg_focus, text)
    end
end

function set_background_foreground(bgcolor, fgcolor, text)
    if text ~= nil then
        return '<bg color="'..bgcolor..'" /><span color="'..fgcolor..'">'..text..'</span>'
    end
end

function set_font(font, text)
    if text ~= nil then
        return '<span font_desc="'..font..'">'..text..'</span>'
    end
end

---- Widget functions
-- Clock
function clock_info(dateformat, timeformat)
    local date = os.date(dateformat)
    local time = os.date(timeformat)

    clockwidget.text = spacer..date..spacer..set_focus_foreground(time)..spacer
end

-- Gmail
function gmail_info()
    local mails = io.popen("python ~/.gmail.py"):read()

    if mails ~= nil then
        gmailwidget.text = spacer..mails..spacer
    end
end

-- Wifi signal strength
function wifi_info(adapter)
    local f = io.open("/sys/class/net/"..adapter.."/wireless/link")
    local wifi_strength = f:read()
    f:close()
    
    if wifi_strength == "0" then
        wifi_strength = set_foreground("#ff6565", wifi_strength)
        naughty.notify({ title      = "Wifi Notification"
                       , text       = "Wireless Network is Down! ("..wifi_strength.."% connectivity)"
                       , timeout    = 5
                       , position   = "top_right"
                       })
    end
    
    wifiwidget.text = spacer..set_focus_foreground("Wifi:")..spacer..wifi_strength.."%"..spacer
end

-- Moc
function moc_info(used_for)
    local src = io.popen("mocp -Q %cs")
    src:close()

    if src == nil then
        return
    elseif src == nil and used_for == "textbox" then
        mocwidget.text = spacer.."Moc not running"..spacer
    else
        if used_for == "textbox" then
            src = io.popen("mocp -Q %state")
            local play_state = src:read()
            src:close()
            local prefix = ""

            if play_state == "PAUSE" then
                prefix = "|| "
            elseif play_state == "PLAY" then
                prefix = ">> "
            end

            if play_state == "STOP" then
                mocwidget.text = spacer..set_focus_foreground("[]")..spacer
            end

        
            if play_state == "PLAY" or state == "PAUSE" then
                src = io.popen("mocp -Q %title")
                local title = src:read()
                src:close()
                title = string.gsub(title, "^%d*", "")
                title = string.gsub(title, "%(.*", "")
                title = awful.util.escape(title)
                mocwidget.text = spacer..set_focus_foreground(prefix)..title -- No spacer here since moc auto-does it
            end
        elseif used_for == "popup" then
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

            return set_focus_foreground("Song:")..spacer..song.."\n"..set_focus_foreground("Artist:")..spacer..artist.."\n"..set_focus_foreground("Album:")..spacer..album.."\n"..set_focus_foreground("Elapsed:")..spacer..ct.."/"..tt
        end
    end
end

-- Battery (BAT1)
function battery_info(adapter, used_for)
    local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")    
    local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")
    local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
    local cur = fcur:read()
    fcur:close()
    local cap = fcap:read()
    fcap:close()
    local sta = fsta:read()
    fsta:close()
    
    local battery = math.floor(cur * 100 / cap)

    if used_for == "progressbar" then
        batbarwidget:bar_data_add("bat", tonumber(battery))
    elseif used_for == "popup" then
        if sta:match("Unknown") then sta = "A/C" end
        return set_focus_foreground("Percent:")..spacer..tonumber(battery).."%".."\n"..set_focus_foreground("State:")..spacer..sta
    elseif used_for == "textbox" then
        if sta:match("Charging") then
            dir = "+"
            battery = battery.."%"
        elseif sta:match("Discharging") then
            dir = "-"
            if tonumber(battery) > 25 and tonumber(battery) < 50 then
                battery = set_foreground("#E6E51E", battery)
            elseif tonumber(battery) <= 25 then
                battery = set_foreground("#FF6565", battery)
            end
            battery = battery.."%"
        else
            dir = "="
            battery = "A/C"
        end

        batterywidget.text = spacer..dir..battery..spacer
    end

    -- Naughtify me when battery gets really low
    if tonumber(battery) <= 15 then
        naughty.notify({ title      = "Battery Notification"
                       , text       = "Battery low!"..spacer..battery.."%"..spacer.."left!"
                       , timeout    = 5
                       , position   = "top_right"
                       })
    end
end

-- Memory
function mem_info(used_for)
    local f = io.open("/proc/meminfo")

    for line in f:lines() do
        if line:match("^MemTotal.*") then
            mem_total = math.floor(tonumber(line:match("(%d+)")) / 1024)
        elseif line:match("^MemFree.*") then
            mem_free = math.floor(tonumber(line:match("(%d+)")) / 1024)
        elseif line:match("^Buffers.*") then
            mem_buffers = math.floor(tonumber(line:match("(%d+)")) / 1024)
        elseif line:match("^Cached.*") then
            mem_cached = math.floor(tonumber(line:match("(%d+)")) / 1024)
        end
    end
    f:close()

    mem_free = mem_free + mem_buffers + mem_cached
    mem_in_use = mem_total - mem_free
    mem_usage_percentage = math.floor(mem_in_use / mem_total * 100)


    if used_for == "progressbar" then
        membarwidget:bar_data_add("mem", tonumber(mem_usage_percentage))
    elseif used_for == "popup" then
        return set_focus_foreground("Percent:")..spacer..mem_usage_percentage.."%".."\n"..set_focus_foreground("Total:")..spacer..mem_in_use.."Mb"
    elseif used_for == "textbox" then
        if tonumber(mem_usage_percentage) >= 15 and tonumber(mem_in_use) >= 306 then
            mem_usage_percentage = set_foreground("#FF6565", mem_usage_percentage)
            mem_in_use = set_foreground("#FF6565", mem_in_use)
        end
        memwidget.text = spacer..mem_usage_percentage.."%"..spacer.."("..mem_in_use.."M)"..spacer
    end
end
