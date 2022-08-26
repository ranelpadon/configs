export XDG_CACHE_HOME=~/.cache

# Show/hide Apple's hidden files.
alias files_show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias files_hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

alias xcode='open -a Xcode'
