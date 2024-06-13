map('"', 'h');
map('h', 'S'); // scroll right
map('S', '"'); // scroll left

map('"', 'l');
map('l', 'D'); // go back
map('D', '"'); // go forward

map('"', 't');
map('t', 'T'); // open tab hints 

// open omni bar in tab mode 
mapkey('<Ctrl-q>', 'Choose a tab with omnibar', function() {
    Front.openOmnibar({type: "Tabs"});
});

addSearchAliasX('wiki', 'Wikipedia', 'https://en.wikipedia.org/w/index.php?search=', 's', 'https://en.wikipedia.org/w/api.php?action=opensearch&search=', function(response) {
	var res = JSON.parse(response.text);
	return res[1];
});
mapkey('owiki', '#8Open Search with alias wiki', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "wiki"});
});

addSearchAliasX('aw', 'Arch Wiki', 'https://wiki.archlinux.org/index.php?search=', 's');
mapkey('oaw', '#8Open Search with alias aw', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "aw"});
});

settings.tabsThreshold = 1000;
settings.defaultSearchEngine = "w";
settings.omnibarSuggestion = true;

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
