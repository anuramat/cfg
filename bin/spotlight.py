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
        {'enabled': True, 'name': 'SPREADSHEETS'},
        {'enabled': True, 'name': 'PRESENTATIONS'},
        {'enabled': True, 'name': 'MUSIC'},
        {'enabled': True, 'name': 'MOVIES'},
        {'enabled': True, 'name': 'MESSAGES'},
        {'enabled': True, 'name': 'MENU_SPOTLIGHT_SUGGESTIONS'},
        {'enabled': True, 'name': 'MENU_OTHER'},
        {'enabled': True, 'name': 'IMAGES'},
        {'enabled': True, 'name': 'FONTS'},
        {'enabled': True, 'name': 'DOCUMENTS'},
        {'enabled': True, 'name': 'DIRECTORIES'},
        {'enabled': True, 'name': 'BOOKMARKS'},
        {'enabled': True, 'name': 'SOURCE'},
    ]

    data['orderedItems'] = settings

    with open(path, 'wb') as file:
        plistlib.dump(data, file)
        

if __name__ == '__main__':
    rel_path = "~/Library/Preferences/com.apple.Spotlight.plist"
    abs_path = os.path.expanduser(rel_path)
    main(abs_path)
