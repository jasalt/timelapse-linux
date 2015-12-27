#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Script that tells if there's light outside (in Jyväskylä / Finland) at this
# moment, or at given timestamp moment.
# Allows timestamp in format 20151013-002401
# Depends on ephem library, written for use with Python 2.7.

import ephem
import sys
from datetime import timedelta, datetime

o = ephem.Observer()
o.lat = '62'  # <-- Customize latitude & longtitude to your liking
o.long = '26'
if len(sys.argv) > 1:  # Use date from first argument if it's given
    # Otherwise use current time
    date_str = sys.argv[1]
    year, month, day = date_str[:4], date_str[4:6], date_str[6:8]
    hour, minute = date_str[9:11], date_str[11:13]
    file_date = "%s/%s/%s %s:%s" % (year, month, day, hour, minute)
    o.date = file_date
    dtn = datetime(int(year), int(month), int(day), int(hour), int(minute))
else:
    dtn = datetime.now()

s = ephem.Sun()
s.compute()

treshold = timedelta(hours=1.4)

last_setting = ephem.localtime(o.previous_setting(s))
last_dark = last_setting + treshold
time_dark = last_dark.time()

last_rising = ephem.localtime(o.previous_rising(s))
last_light = last_rising - treshold
time_light = last_light.time()

time_now = dtn.time()

if time_light < time_now < time_dark:
    print("There's light!")
    exit(0)
else:
    print("It's dark!")
    exit(1)
