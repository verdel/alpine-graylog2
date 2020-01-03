#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import re

if __name__ == '__main__':
    r = requests.get('https://www.graylog.org/downloads')
    match = re.match('.*<a href="(.*graylog-(\d\.\d\.\d).tgz)"', r.text, re.DOTALL | re.M)
    if match:
        r = requests.get(match.group(1))
        with open('/opt/graylog-{}.tgz'.format(match.group(2)), 'wb') as f:
            f.write(r.content)
