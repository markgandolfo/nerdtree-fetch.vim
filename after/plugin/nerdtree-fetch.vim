" Nerdtree wget in current directory
" URL: https://github.com/markgandolfo/nerdtree-fetch.vim
" Author: Mark Gandolfo
" Github: http://github.com/markgandolfo
"
if exists("g:loaded_nerdtree_fetch_menuitem")
    finish
endif
let g:loaded_nerdtree_fetch_menuitem = 1

call NERDTreeAddMenuItem({
            \ 'text': '(f)etch',
            \ 'shortcut': 'f',
            \ 'callback': 'NERDTreeFetcher'})

function! NERDTreeFetcher()
    let curDir = g:NERDTreeDirNode.GetSelected()
    let fetchURL = input("Fetch a file.\n" .
                        \ "==========================================================\n" .
                        \ "Enter the url of the file to fetch:                       \n" .
                        \ "")

    if fetchURL ==# ''
        echo "Cannot fetch an empty url."
        return
    endif

    try
        let downloadUrl = shellescape(url)
        let downloadDir = curDir.path.str({'format': 'Cd'}) . '/'
        let cmd = 'wget ' . downloadUrl . ' -P ' . downloadDir . ' 2>/dev/null || cd ' . downloadDir . ' && curl -O  ' . downloadUrl

        if cmd != ''
            let success = system(cmd)
            call curDir.refresh()
            call NERDTreeRender()
            call feedkeys("R")
        else
            echo "Fetch Aborted, something went wrong"
        endif
    catch /^NERDTree/
        echo "NERDTree fetch didnt fetch anything"
    endtry
