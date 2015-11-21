#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Script that tells if there's light outside (in Jyväskylä / Finland) at this
# moment. Depends on ephem library, written for use with Python 2.7.
import ephem
from datetime import timedelta, datetime
from time import time

o = ephem.Observer()
o.lat = '62'  # <-- Customize latitude & longtitude to your liking
o.long = '26'
s = ephem.Sun()
s.compute()

treshold = timedelta(hours=2)

last_setting = ephem.localtime(o.previous_setting(s))
last_dark = last_setting + treshold
time_dark = last_dark.time()

# ei asetu mikäli ei olla jo uudessa päivässä
last_rising = ephem.localtime(o.previous_rising(s))
last_light = last_rising - treshold
time_light = last_light.time()

#dtn = datetime(2015, 10, 11, 4, 0)
dtn = datetime.now()
time_now = dtn.time()


if time_light < time_now < time_dark:
    print("There's light!")
    exit(0)
else:
    print("It's dark!")
    exit(1)
