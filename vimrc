" Notes {
"   For options, check vim man page of many other .vimrc configurations shared on the web.
"   If you have interesting suggestions, please feel free to make an issue or fork this and submit a pull request.
" }

" General {
    set nocompatible                    " use vim defaults
    set encoding=utf-8                  " use utf-8 as encoding
    set laststatus=2                    " Always display the statusline in all windows
    set showtabline=2
    set noshowmode                      " Hide the default mode text (e.g. -- INSERT -- below the statusline)
    set history=1000                    " increase history
    set backup                          " backups are useful
    set backupdir=~/.vim/backupfiles//
    set directory=~/.vim/undofiles//
    if v:version < 703
        set undodir=~/.vim/undofiles//  " vim versions lower than 7.3 don't know undodir
    endif
    set wildmenu                        " show list instead of just completing
    set wildmode=list:longest,full      " command <tab> completion, list matches, then longest common part, then all
    set shortmess=aTItoO                " disable the splash screen (and some various tweaks for messages).
    " Behavior {
        set clipboard=unnamed           " integrate with operating systems clipboard
        set mouse=a                     " automatically enable mouse usage
        set scrolloff=3                 " minimum lines to keep above and below cursor
        set showcmd                     " select characters/lines in visual mode
        set ttyfast                     " smoother changes
        set backspace=indent,eol,start  " osx backspace fix
    " }

    " Formatting {
        set sm                          " show matching braces
        "set autoindent                 " indent at the same level of the previous line
        "set smartindent                " indent while recognizing C syntax
        set cindent                     " more cleverly indenting than the other two
        "filetype indent on             " autoindent on opening file
    " }

    " Vim UI {
        " Font Setting { 
            " NOTE: some fonts do not have the correct unicode symbols for the
            " Powerline plugin. Make sure to use a patched font.
            " For compatible fonts and more information, see: https://github.com/Lokaltog/powerline-fonts
            set gfn=PragmataPro:h13     " this only affects the GUI VIM
                                        " if using console version, change the
                                        " font in the console settings
        " }
        color molokai                   " color scheme
        syntax on                       " enable syntax highlighting when possible
        set ls=2                        " allways show statusline
        set expandtab                   " insert space characters whenever tab key is pressed.
        set tabstop=4                   " set number of spaces for tab character as 4
        set softtabstop=4               " let backspace delete indent
        set shiftwidth=4                " number of spaces to (auto)indent
        set ruler                       " show cursor position all the time
        set number                      " show line numbers
        set title                       " show title in console title bar
        set cmdheight=1
        set wrap
        set linebreak
        set showbreak=\ →\ \ 
        set list
        set listchars=trail:·,precedes:«,extends:»,tab:▸\ 
        " TabLine UI {
            set tabline=%!MyTabLine()               " set the tabline using the MyTabLine function
            hi TabLineFill ctermfg=237 ctermbg=237  " background
            hi TabLineSel ctermfg=28 ctermbg=148    " selected tab
            hi TabLine ctermfg=253 ctermbg=239      " tab
        " }
    " }

" }

" Searching {
    set hlsearch                        " highlight searches
    set incsearch                       " do incremental searching (while typing)
    set ignorecase                      " ignore cases while searching
    hi Search cterm=NONE 
            \ ctermfg=28
            \ ctermbg=148
" }

" Commands {
    command W execute 'silent w !sudo tee % >/dev/null' | silent e! %
"}

" Reformat fixes (when using gg=G) {
    " for xml files
    "au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
    au FileType xml setlocal equalprg=tidy\ -i\ -xml
    " for perl
    "au FileType pl  setlocal equalprg=perltidy\ -nola
" }

" Filetype AutoCompl {
    filetype on
    filetype plugin on
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
"}

" NERDTree Options {
    " automatically close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI=1
"}

" indentLine Options {
    " NOTE: VIM must be compiled with conceal (Vim 7.3) for this to work
    let g:indentLine_char = '┊'
    let g:indentLine_first_char = '┊'
    let g:indentLine_showFirstIndentLevel = 1
    let g:indentLine_color_term = 0
" }

" Key (re)mappings {
    " use ctrl+n to toggle the NERDTree
    map <C-n> :NERDTreeToggle<cr>
" }

" Functions {
    " VIM Addon Manager
    fun SetupVAM()
        let c = get(g:, 'vim_addon_manager', {})
        let g:vim_addon_manager = c
        let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
        let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
        if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
            execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager ' 
                \ shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
        endif
        call vam#ActivateAddons(['powerline','AutoComplPop','L9', 'The_NERD_tree','indentLine'], {'auto_install' : 0})
    endfun

    " Content for tabs
    function MyTabLine()
      let s = '' " complete tabline goes here
      for t in range(tabpagenr('$')) " loop through each tab page
        if t + 1 == tabpagenr() " select the highlighting for the buffer names
          let s .= '%#TabLineSel#'
        else
          let s .= '%#TabLine#'
        endif
        let s .= ' ' " empty space
        let s .= '%' . (t + 1) . 'T' " set the tab page number (for mouse clicks)
        let s .= t + 1 . ' ' " set page number string
        " get buffer names and statuses
        let n = ''  "temp string for buffer names while we loop and check buftype
        let m = 0 " &modified counter
        let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
        for b in tabpagebuflist(t + 1) " loop through each buffer in a tab
          " buffer types: quickfix gets a [Q], help gets [H]{base fname}
          " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
          if getbufvar( b, "&buftype" ) == 'help'
            let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
          elseif getbufvar( b, "&buftype" ) == 'quickfix'
            let n .= '[Q]'
          else
            let n .= pathshorten(bufname(b))
          endif
          if getbufvar( b, "&modified" ) " check and ++ tab's &modified count
            let m += 1
          endif
          if bc > 1 " no final ' ' added...formatting looks better done later
            let n .= ' '
          endif
          let bc -= 1
        endfor
        if m > 0 " add modified label [n+] where n pages in tab are modified
          "let s .= '[' . m . '+]'
          let s.= '+ '
        endif
        if n == '' " add buffer names
          let s .= '[No Name]'
        else
          let s .= n
        endif
        let s .= ' ' " switch to no underlining and add final space to buffer list
      endfor
      let s .= '%#TabLineFill#%T' " after the last tab fill with TabLineFill and reset tab page nr
      if tabpagenr('$') > 1 " right-align the label to close the current tab page
        let s .= '%=%#TabLine#%999XX'
      endif
      return s
    endfunction

    if ! has('gui_running')  " make powerline faster
        set ttimeoutlen=10
        augroup FastEscape
            autocmd!
            au InsertEnter * set timeoutlen=0
            au InsertLeave * set timeoutlen=1000
        augroup END
    endif

" }

call SetupVAM() "Run Vim Addon Manager function to retrieve/update plugins/addons.

