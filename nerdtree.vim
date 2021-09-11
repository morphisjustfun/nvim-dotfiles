" Fix cursorline

let NERDTreeMinimalUI=1
function DisableNerdTreeSigns()
   set nocursorline
   set nocursorcolumn
endfunction

" Autocall function when a nerdtree buffer is opened

autocmd FileType nerdtree call DisableNerdTreeSigns()
