#!/usr/bin/env python3

from collections import defaultdict
import sys
import re

symbol = sys.argv[1]
if symbol == "+":
    symbol = "\\" + symbol
exp = f'{symbol}\\S+'
pattern = re.compile(exp)

if not symbol:
    raise ValueError()

tasks_by_tags=defaultdict(list)
for task in sys.stdin:
    tags = pattern.findall(task)
    task = pattern.sub("", task)
    task = task.strip()
    for tag in tags:
        tasks_by_tags[tag.strip()].append(task)
    if len(tags) == 0:
        tasks_by_tags[f'-{symbol[-1]}'].append(task)

delim = '\0'
res = str(len(tasks_by_tags) * 2)
for tag, tasks in tasks_by_tags.items():
    res += f"{delim}{tag}{delim}{'\n'.join(tasks[::-1])}"

print(res, end='')
