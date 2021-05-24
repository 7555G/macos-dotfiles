function! SetSignColumn(file_name, is_modifiable)
    if empty(a:file_name) || !a:is_modifiable
        let &signcolumn = 'no'
        let b:gutterwidth = 0
    elseif (&signcolumn =~ '')
        let &signcolumn = 'yes'
        let b:gutterwidth = 2
    endif
endfunction

augroup vimrc
    " clear existing definitions in this group
    autocmd!

    " enable sign column (when appropriate)
    autocmd BufWinEnter,BufRead,BufWrite *
    \   call SetSignColumn(@%, &modifiable)

    " autosave named files
    autocmd CursorHold ?* nested if empty(&buftype) | update | endif

    " convert always to utf-8
    autocmd BufWinEnter,BufRead,BufWrite ?* silent! set fileencoding=utf-8

    " spell check text files
    autocmd FileType tex,latex,text,markdown
    \   set formatoptions=tawcroql
    \|  set spell spelllang=en_us,el,cjk

    " syntax highlight a minimum of 2000 lines (faster scrolling)
    autocmd Syntax * syn sync minlines=2000 maxlines=2000

    " enable syntax, load default syntax, and show guides for non-text files
    let textFiletypes =
    \   ['xml', 'yaml', 'markdown', 'qf', 'help', 'tex', 'latex', 'text', '']
    autocmd BufWinEnter,BufRead * nested
    \   if !exists("g:syntax_on")
    \|      syntax on
    \|      syntax enable
    \|  endif
    \|  set concealcursor=inc
    \|  set conceallevel=1
    \|  if index(textFiletypes, &filetype) < 0
    \|      source $HOME/.vim/after/syntax/default.vim
    \|      source $HOME/.vim/after/syntax/indent_guides.vim
    \|  endif

    " use xml syntax for some extensions
    autocmd BufWinEnter,BufRead,BufWrite
    \   *.sdf,*.world,*.model,*.config,*.launch,*.plist set ft=xml

    " cmake custom autocompletion
    autocmd BufWinEnter,BufRead,BufWrite CMakeLists.txt,*.cmake
    \   set complete=.,k
    \|  set dictionary=$HOME/.vim/words/cmake.txt

    " close loclists with buffer
    autocmd QuitPre * if empty(&buftype) | lclose | endif

    " remember state
    "au BufWinLeave,BufWrite * silent! mkview
    "au BufRead * silent! loadview
augroup END