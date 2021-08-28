unmap k

map e scrollDown
map u scrollUp

# map <space> scrollDown
# map <c-space> scrollUp

map E scrollPageDown
map U scrollPageUp

unmap n
unmap i
# map n scrollLeft
# map i scrollRight
map n LinkHints.activate
map i LinkHints.activateOpenInNewTab
map <c-p> LinkHints.activateOpenIncognito

map N goBack
map I goForward

unmap o
map o focusInput

map t Vomnibar.activateInNewTab
map T Vomnibar.activateEditUrlInNewTab
map a Vomnibar.activate
map A Vomnibar.activateEditUrl

unmap ge
unmap gE

map gn firstTab
map gi lastTab

unmap W
map w  removeTab
map W restoreTab

map m performFind
map M performBackwardsFind

unmap f
map f LinkHints.activateOpenInNewTab
unmap F
map F LinkHints.activate

map gp moveTabToIncognito
