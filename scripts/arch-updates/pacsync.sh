#!/bin/bash

# This issues a command to 1. Sync the package database, 
# 2. Check for upgradable packages, 3. print the URL of any possible upgrade. 
# The output of our command gets written to updates.log, which we will use 
# conky_updates.sh to parse to see if there are any available updates.

pacman -Syup --noprogressbar > /home/raziel/scripts/arch-updates/updates.log
