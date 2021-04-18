" Mappings: `ct` for theirs, `co` for ours, and `cb` for both.
" HEAD is always `ours` which is the current change,
" `theirs` is the incoming change,

" Disable the default highlight group
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin guifg=#e06c75
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerSeparator guifg=#e06c75
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guifg=#e06c75
