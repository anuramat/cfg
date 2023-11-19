# pylint: disable=C0111
c = c  # type: ignore
config = config  # type: ignore

import dracula.draw
dracula.draw.blood(c, {"spacing": {"vertical": 6, "horizontal": 8}})

config.load_autoconfig(False)

c.editor.command = ['foot', 'nvim', '{}'] # editor for config-edit

c.search.ignore_case = 'smart'
c.search.incremental = True
c.search.wrap = False

c.scrolling.smooth = False

c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
    '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
    '!gist':    'https://gist.github.com/search?q={}',
    '!gi':      'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    '!gn':      'https://news.google.com/search?q={}',
    '!ig':      'https://www.instagram.com/explore/tags/{}',
    '!m':       'https://www.google.com/maps/search/{}',
    '!p':       'https://pry.sh/{}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    '!yt':      'https://www.youtube.com/results?search_query={}'
}

c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://easylist.to/easylist/easylist.txt',
    'https://secure.fanboy.co.nz/fanboy-annoyance.txt',
    'https://easylist-downloads.adblockplus.org/ruadlist.txt',
]

c.url.start_pages = ["qute://help/index.html"]
c.url.default_page = "qute://help/index.html"

c.colors.webpage.darkmode.enabled = False
c.colors.webpage.preferred_color_scheme = 'dark'
