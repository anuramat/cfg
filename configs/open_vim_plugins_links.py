#!/usr/bin/env python3

"""
opens github links for all plugins in init.vim
useful to check for deprecated stuff...
"""

import webbrowser as wb

def read_plugins(filename):
    with open(filename, 'r') as config:
        lines = config.readlines()
        lines = [line for line in lines if 'Plug' in line]
        plugins = [line.split("'")[1].strip('/') for line in lines]
    return plugins


def main():
    # read plugins from file
    plugins = read_plugins('init.vim')

    # construct github links
    links = ['https://github.com/'+plugin for plugin in plugins]

    # open browser windows
    wb.open(links[0], new=1)
    for link in links[1:]:
        wb.open(link)

if __name__ == '__main__':
    main()
