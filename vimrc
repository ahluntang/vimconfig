" Notes {
"   Personal .vimrc file of Ah-Lun Tang
"   You can find me at http://ahlun.be and http://blog.ahlun.be
"   License info: use it, share it, do whatever you want with it.
"   This .vimrc configuration is based on my personal flavors on how I want to use vim
"   For options, check vim man page of many other .vimrc configurations shared on the web.
"   If you have interesting options that you think I could use, please feel free to comment or contact me.
"
" }

" General {
    set nocompatible                    " use vim defaults          
    set encoding=utf-8                  " use utf-8 as encoding
    set laststatus=2
    set history=1000                    " increase history
    set backup                         " backups are useful
    set backupdir=~/.vimscratch/backup//,~/tmp//,~//
    set directory=~/.vimscratch//,~/tmp//,~//
    if v:version < 703
        set undodir=~/.vimscratch/undo//,~/tmp//,~//
    endif
    set wildmenu                        " show list instead of just completing
    set wildmode=list:longest,full      " command <tab> completion, list matches, then longest common part, then all
	set shortmess+=I
    " Behavior {
        set mouse=a                     " automatically enable mouse usage
        set scrolloff=3                 " minimum lines to keep above and below cursor
        set showcmd                     " select characters/lines in visual mode
        set ttyfast                     " smoother changes
    " }

    " Formatting {
        set sm                          " show matching braces
        "set autoindent                 " indent at the same level of the previous line
        "set smartindent                " indent while recognizing C syntax
        "set cindent                        " more cleverly indenting than the other two
        "filetype indent on             " autoindent on opening file
    " }

    " Vim UI {
        color molokai
        set gfn=PragmataPro:h13 "set gfn=Meslo\ LG\ L\ Regular\ for\ Powerline:h12
        "set gfn=Menlo\ for\ Powerline:h12 "set gfn=Meslo\ LG\ L\ Regular\ for\ Powerline:h12
        syntax on                       " enable syntax highlighting when possible
        set ls=2                        " allways show statusline
        set tabstop=4                   " set number of spaces for tab character as 4
        set softtabstop=4               " let backspace delete indent
        set shiftwidth=4                " number of spaces to (auto)indent
        set ruler                       " show cursor position all the time
        set number                      " show line numbers
        set title                       " show title in console title bar
        set cmdheight=1
        "set nowrap                      " disable automatic line wrapping
		set wrap
		set linebreak
		set showbreak=\ >\ 
		set showtabline=2
		set laststatus=2 " Always display the statusline in all windows
		set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
		"set guitablabel=%N/\ %t\ %M
        hi TabLineFill ctermfg=237 ctermbg=237
        hi TabLineSel ctermfg=28 ctermbg=148
        hi TabLine ctermfg=253 ctermbg=239
    " }

" }

" Searching {
    set hlsearch                        " highlight searches
    set incsearch                       " do incremental searching (while typing)
    set ignorecase                      " ignore cases while searching
    hi Search cterm=NONE ctermfg=grey ctermbg=blue
" }

" Commands {
    command W execute 'silent w !sudo tee % >/dev/null' | silent e! %
"}


" Key (re)mappings {
    " use backslash button to convert current file to html with syntax coloring
    "map \ :runtime! syntax/2html.vim<cr>:w<cr>:clo<cr>
    " use q to save file and quit
    "map q :wq<cr>
    " use v to quit without saving
    "map v :q<cr>
    " use V to quit without saving (forced)
    "map V :q!<cr>
    " use F4 to save, make executable and execute
    "map <F4> :call ChmodExec<cr>
    " use F5 to save, compile with Clang and execute
    "map <F5> :call CompileRunClang()<cr>
    " use F6 to save, compile with Gcc and execute
    "map <F6> :call CompileRunGcc()<cr>
    " use F7 to save and execute with perl
    "map <F7> :call PerlExec()<cr>
" }

" Functions {
    func! PerlExec()
        exec "w"
        exec "!perl ./%"
    endfunc

    func! ChmodExec()
        exec "w"
        exec "!chmod a+x %"
        exec "! ./%"
    endfunc

    func! CompileRunGcc()
        exec "w"
        exec "!gcc -arch x86_64 -arch i386 -lstdc++ % -o bin%<"
        exec "! ./bin%<"
    endfunc

    func! CompileRunClang()
        exec "w"
        exec "!clang -arch x86_64 -arch i386 -lstdc++ % -o bin%<"
        exec "! ./bin%<"
    endfunc

    fun SetupVAM()
      let c = get(g:, 'vim_addon_manager', {})
      let g:vim_addon_manager = c
      let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
      let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
      if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
        execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
                    \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
      endif
      call vam#ActivateAddons(['powerline','AutoComplPop','L9'], {'auto_install' : 0})
    endfun      
" }

"Run function to retrieve/update plugins/addons.
call SetupVAM()


set tabline=%!MyTabLine()
function MyTabLine()
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " select the highlighting for the buffer names
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " empty space
    let s .= ' '
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= t + 1 . ' '
    " get buffer names and statuses
    let n = ''  "temp string for buffer names while we loop and check buftype
    let m = 0 " &modified counter
    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        let n .= pathshorten(bufname(b))
        "let n .= bufname(b)
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      "let s .= '[' . m . '+]'
      let s.= '+ '
    endif
    " add buffer names
    if n == ''
      let s .= '[No Name]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space to buffer list
    "let s .= '%#TabLineSel#' . ' '
    let s .= ' '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif
  return s
endfunction

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
