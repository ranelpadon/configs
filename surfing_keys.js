// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
    Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
map('gt', 'T');

// an example to remove mapkey `Ctrl-i`
unmap('<Ctrl-i>');

map('<Ctrl-l>', 'E');
map('<Ctrl-u>', 'R');

map('a', 't');
map('A', 'go');
unmap('t');
map('t', 'on');
unmap('on');


map('F', 'f');
unmap('f');
map('f', 'C');

unmap('s');
map('s', 'n');
unmap('n');
map('K', 'S');
map('I', 'D');

map('u', 'e');
unmap('e');
//map('n', 'j');
map('e', 'k');

map('q', 'x');
unmap('x');
map('Q', 'X');
map('W', 'X');
map('p', 'cc');

// search
map('gd', 'od'); // ddg
map('gy', 'oy'); // youtube

// wikipedia
mapkey('gw', '#8Open Search with alias e', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "e"});
});

// private window
mapkey('gp', '#8Open incognito window', function() {
    RUNTIME('openIncognito', {
        url: window.location.href
    });
});

map('h', 'i');
unmap('i');


addSearchAliasX('g', 'duckduckgo', 'https://duckduckgo.com/?q=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});



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
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.