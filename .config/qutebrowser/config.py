config.load_autoconfig(False)
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:136.0) Gecko/20100101 Firefox/139.0', 'https://accounts.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///Users/brecord/Library/Application%20Support/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_remote_urls', True, 'file:///Users/brecord/Library/Application%20Support/qutebrowser/userscripts/*')
c.editor.command = ["kitty", "--single-instance", "-T", "auxiliary text edit", "nvim", "{file}", "+startinsert", "+call cursor({line}, {column})"]
c.scrolling.smooth = True
c.url.default_page = 'https://google.com/'
c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}'}
c.url.start_pages = 'https://google.com'
