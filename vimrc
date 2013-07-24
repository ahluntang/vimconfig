" Notes {
"	Personal .vimrc file of Ah-Lun Tang
"	You can find me at http://ahlun.be and http://blog.ahlun.be

"	License info: use it, share it, do whatever you want with it.
"	This .vimrc configuration is based on my personal flavors on how I want to use vim
"	For options, check vim man page of many other .vimrc configurations shared on the web.
"	If you have interesting options that you think I could use, please feel free to comment or contact me.
"
"
"	Also check out snipMate.vim plugin at
"	- http://vimeo.com/3535418 (introductory screencast)
"	- http://www.vim.org/scripts/script.php?script_id=2540 (plugin page at vim.org)
"	- https://github.com/msanders/snipmate.vim (github project)
"	Use git to install snipMate:
"		git clone git://github.com/msanders/snipmate.vim.git
"		cd snipmate.vim
"		cp -R * ~/.vim
" }

" General {
"	
	set nocompatible					" use vim defaults
	scriptencoding utf-8				" use utf-8 as encoding
	set encoding=utf-8
	set laststatus=2
	set history=1000					" increase history
	color molokai
	"set gfn=Meslo\ LG\ L\ Regular\ for\ Powerline:h12
	set gfn=Menlo\ for\ Powerline:h12
	"set backup							" backups are useful
	set wildmenu						" show list instead of just completing
	set wildmode=list:longest,full		" command <tab> completion, list matches, then longest common part, then all
	" Behavior {
		set mouse=a						" automatically enable mouse usage
		set scrolloff=3					" minimum lines to keep above and below cursor
		set showcmd						" select characters/lines in visual mode
		set ttyfast						" smoother changes
	" }

	" Formatting {
		set sm							" show matching braces
		"set autoindent					" indent at the same level of the previous line
		"set smartindent				" indent while recognizing C syntax
		"set cindent						" more cleverly indenting than the other two
		"filetype indent on				" autoindent on opening file
	" }

	" Vim UI {
		syntax on						" enable syntax highlighting when possible
		set ls=2						" allways show statusline
		set tabstop=4					" set number of spaces for tab character as 4
		set softtabstop=4				" let backspace delete indent
		set shiftwidth=4				" number of spaces to (auto)indent
		set ruler						" show cursor position all the time
		set number						" show line numbers
		set title						" show title in console title bar
		set nowrap						" disable automatic line wrapping
	" }

" }
" Searching {
	set hlsearch						" highlight searches
	set incsearch						" do incremental searching (while typing)
	set ignorecase						" ignore cases while searching
	hi Search cterm=NONE ctermfg=grey ctermbg=blue
" }

" Key (re)mappings {
	" use backslash button to convert current file to html with syntax coloring
	map \ :runtime! syntax/2html.vim<cr>:w<cr>:clo<cr>
	" use q to save file and quit
	map q :wq<cr>
	" use v to quit without saving
	map v :q<cr>
	" use V to quit without saving (forced)
	map V :q!<cr>
	" use F4 to save, make executable and execute
	map <F4> :call ChmodExec<cr>
	" use F5 to save, compile with Clang and execute
	map <F5> :call CompileRunClang()<cr>
	" use F6 to save, compile with Gcc and execute
	map <F6> :call CompileRunGcc()<cr>
	" use F7 to save and execute with perl
	map <F7> :call PerlExec()<cr>
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
" }
        fun SetupVAM()
          let c = get(g:, 'vim_addon_manager', {})
          let g:vim_addon_manager = c
          let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
          let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
          " let g:vim_addon_manager = { your config here see "commented version" example and help
          if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
            execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
                        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
          endif
          call vam#ActivateAddons(['powerline'], {'auto_install' : 0})
          " Also See "plugins-per-line" below
        endfun
        call SetupVAM()
