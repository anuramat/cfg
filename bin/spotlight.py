#!/usr/bin/env python3
import plistlib
import os

def main(path):
    with open(path, 'rb') as file:
        data = plistlib.load(file)

    settings =  [
        {'enabled': True, 'name': 'SYSTEM_PREFS'},
        {'enabled': True, 'name': 'PDF'},
        {'enabled': True, 'name': 'MENU_EXPRESSION'},
        {'enabled': True, 'name': 'MENU_DEFINITION'},
        {'enabled': True, 'name': 'MENU_CONVERSION'},
        {'enabled': True, 'name': 'EVENT_TODO'},
        {'enabled': True, 'name': 'CONTACT'},
        {'enabled': True, 'name': 'APPLICATIONS'},
        {'enabled': False, 'name': 'SPREADSHEETS'},
        {'enabled': False, 'name': 'PRESENTATIONS'},
        {'enabled': False, 'name': 'MUSIC'},
        {'enabled': False, 'name': 'MOVIES'},
        {'enabled': False, 'name': 'MESSAGES'},
        {'enabled': False, 'name': 'MENU_SPOTLIGHT_SUGGESTIONS'},
        {'enabled': False, 'name': 'MENU_OTHER'},
        {'enabled': False, 'name': 'IMAGES'},
        {'enabled': False, 'name': 'FONTS'},
        {'enabled': False, 'name': 'DOCUMENTS'},
        {'enabled': False, 'name': 'DIRECTORIES'},
        {'enabled': False, 'name': 'BOOKMARKS'},
        {'enabled': False, 'name': 'SOURCE'},
    ]

    data['orderedItems'] = settings

    with open(path, 'wb') as file:
        plistlib.dump(data, file)
        

if __name__ == '__main__':
    rel_path = "~/Library/Preferences/com.apple.Spotlight.plist"
    abs_path = os.path.expanduser(rel_path)
    main(abs_path)
