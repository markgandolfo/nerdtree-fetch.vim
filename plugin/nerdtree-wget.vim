" Nerdtree wget in current directory
" Author: Mark Gandolfo
"
if exists("g:loaded_nerdtree_wget_menuitem")
    finish
endif
let g:loaded_nerdtree_wget_menuitem = 1

call NERDTreeAddMenuItem({
            \ 'text': '(w)get',
            \ 'shortcut': 'w',
            \ 'callback': 'NERDTreeWGeter'})

function! NERDTreeWGeter()
    let curDir = g:NERDTreeDirNode.GetSelected()
    let wgetURL = input("Create a symbolic link\n" .
                        \ "==========================================================\n" .
                        \ "Enter the url of the file to wget:                        \n" .
                        \ "")
    Bundle 'EvanDotPro/nerdtree-symlink'
    if wgetURL ==# ''
        echo "Cannot fetch an empty url."
        return
    endif

    try
        let cmd = 'wget ' . shellescape(wgetURL) . ' ' . curDir.path.str({'format': 'Cd'}) . '/'

        if cmd != ''
            let success = system(cmd)
            call curDir.refresh()
            call NERDTreeRender()
            call feedkeys("R")
        else
            echo "wget Aborted."
        endif
    catch /^NERDTree/
        echo "Wget didnt fetch anything"
    endtry
endfunction
