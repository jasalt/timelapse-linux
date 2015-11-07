#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Script that tells if there's light outside (in Jyväskylä / Finland) at this
# moment. Depends on ephem library, written for use with Python 2.7.
import ephem
from datetime import timedelta, datetime

o = ephem.Observer()
o.lat = '62'  # <-- Customize latitude & longtitude to your liking
o.long = '26'
s = ephem.Sun()
s.compute()

dt_setting = ephem.localtime(o.previous_setting(s))
dt_dark = dt_setting + timedelta(hours=1)

dt_rising = ephem.localtime(o.next_rising(s))
dt_light = ephem.localtime(o.next_rising(s)) - timedelta(hours=1)

dt_now = datetime.now()

if dt_dark < dt_now < dt_light:
    print("It's dark!")
    exit(1)
else:
    print("There's light!")
    exit(0)
