#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Parser RSS
# Jérôme Mahuet
#
# python-rss.py URL nombre

import sys, os
from feedparser import parse

url = sys.argv[1]
number = int(sys.argv[2])
it = 0
string = ""

myfeed = parse(url)
for item in myfeed['entries']:
	if(it <= number):
		string += " " + item.title + " "
		it = it + 1

print string
