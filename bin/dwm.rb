# Dwm statusbar feeding script by Gigamo <gigamo@gmail.com>
# Run like this in .xinitrc or however you start your WM:
#   exec ruby /path/to/dwm.rb | /path/to/dwm

def batteryInfo(adapter)
  fcur = IO.read("/sys/class/power_supply/#{adapter}/charge_now").to_i
  fcap = IO.read("/sys/class/power_supply/#{adapter}/charge_full").to_i
  fsta = IO.read("/sys/class/power_supply/#{adapter}/status").chop

  dir = ""
  battery = (fcur * 100 / fcap)

  if fsta == "Charging"
    dir = "^"
    battery = "#{battery} (A/C)"
  elsif fsta == "Discharging"
    dir = "v"
    if battery.to_i < 10
      battery = "Battery low! #{battery}% remaining"
    end
    battery = battery
  else
    dir = "="
    battery = "A/C"
  end

  return "Bat: "+dir+battery.to_s+dir
end

def clockInfo(format)
  Time::now.strftime(format)
end

def wifiInfo(adapter)
  fwif = IO.read("/sys/class/net/#{adapter}/wireless/link")
  
  if fwif == "0"
    fwif = "Network Down"
  else
    fwif = fwif.chop+"%"
  end

  return "Wifi: "+fwif
end

def run()
  final = ""
  
  final += wifiInfo("wlan0")+" | "
  
  final += batteryInfo("BAT1")+" | "
  
  final += clockInfo("%d/%m/%Y %T")
  
  final
end

while true do
  begin
	puts run()
	$stdout.flush
	sleep 1.0
  rescue StandardError => err
	puts "Error!"
	$stdout.flush
  rescue Exception => exp
	puts "Exception!"
	$stdout.flush
  end
end
