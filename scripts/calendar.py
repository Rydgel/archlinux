#!/usr/bin/env python
#-*- coding:utf-8 -*-

import datetime
import calendar
import re
import sys 

if __name__ == '__main__':
  
	today = datetime.datetime.date(datetime.datetime.now())

	print today.month


	lol = calendar.monthdatescalendar(2008,10)
	
	print lol
