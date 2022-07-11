#!/usr/bin/env python3

"""
finds deprecated vim plugins
auto mode: searches for "deprecat" substrings in github repo pages
manual mode: opens all github links
"""

import webbrowser as wb
import urllib.request

def main():

    answer = input('manual/auto/exit:')
    if answer == 'manual':
        manual = True
    elif answer == 'auto':
        manual = False
    else:
        return

    # read plugins from file
    filename = 'init.vim'
    with open(filename, 'r') as config:
        lines = config.readlines()
        lines = [line for line in lines if 'Plug' in line]
        plugins = [line.split("'")[1].strip('/') for line in lines]

    # construct github links
    links = ['https://github.com/'+plugin for plugin in plugins]
    
    # search for keyword in 
    archived_str = 'This repository has been archived by the owner. It is now read-only.'
    if not manual:
        for i, link in enumerate(links):
            print(f'{i+1}/{len(links)}...')
            response = urllib.request.urlopen(link)
            html = str(response.read())
            if 'deprec' in html.lower() or archived_str in html:
                print(f'{link} might be deprecated!')

    # open browser windows
    if manual:
        for link in links:
            wb.open(link)

if __name__ == '__main__':
    main()
