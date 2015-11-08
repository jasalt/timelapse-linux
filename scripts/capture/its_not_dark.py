#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Script that tells if there's light outside (in Jyväskylä / Finland) at this
# moment. Depends on ephem library, written for use with Python 2.7.
import ephem
from datetime import timedelta

o = ephem.Observer()
o.lat = '62'  # <-- Customize latitude & longtitude to your liking
o.long = '26'
s = ephem.Sun()
s.compute()

last_setting = ephem.localtime(o.previous_setting(s))
last_dark = last_setting + timedelta(hours=1)

last_rising = ephem.localtime(o.previous_rising(s))
last_light = last_rising - timedelta(hours=1)

if last_light < last_dark:
    print("It's dark!")
    exit(1)
else:
    print("There's light!")
    exit(0)
