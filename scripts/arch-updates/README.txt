By Vredfreak (http://vredfreak.atspace.com/projects.html)

This is a program for people who use Arch Linux.  It notifies you if any of the packages on your system  have upgrades available in the repos.  This is completely written by me and you are free to modify, copy, distribute, etc... any way you see fit.  It would be nice if you would mention me if you distribute the script.  This one is a bit more complicated than the other conky scripts I have available, so please read the rest of this document for usage instructions.

Requirements:
So long as you have perl (and you do), then you're alright.

How to Use:

Open pacsync.sh in an editor.  Change the path to point to updates.log (it's the same directory this README is in).  As root, copy pacsync.sh into /etc/cron.hourly (or whatever your preference is.  You can also set it up through crontab -e if you want).  Make sure that cron is added to the daemons list in /etc/rc.conf.  Either reboot or restart cron.

As a regular user, open conky-updates.pl in an editor and change the path to point to updates.log.

Add a line something like this to ~/.conkyrc:
${color #3399ff}${texeci 10800 perl /PATH/TO/conky-updates.pl}

Change the color to whatever you need, and change the path to point to conky-updates.pl.
 texeci 10800 indicates how often the program will run (in seconds).  In this example, it will run every 3 hours (10800 seconds).  Change to suit your needs.