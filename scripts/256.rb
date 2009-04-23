#!/usr/bin/env ruby

@i=0

while @i <= 256
  if @i < 10
    print "\x1b[48;5;#{@i}m  \x1b[0m   #{@i}"
  elsif @i < 100
    print "\x1b[48;5;#{@i}m  \x1b[0m  #{@i}"
  else 
    print "\x1b[48;5;#{@i}m  \x1b[0m #{@i}"
  end
  @i=@i+1
end
