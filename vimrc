set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
" ------------------------------------------------------------------------------
" Predefined variables to be used later in this script.
" ------------------------------------------------------------------------------
" vimfiles: path of user-wise Vim directory. 
if has("win32")
	let vimfiles = $HOME."\\vimfiles"
else
	let vimfiles = $HOME."\\.vim"
endif

" Default wrap column.
let wrap_col = 80

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

let $LANG="en"

" Disable Python plugin recommended style (for example keeps tab = 8 spaces).
let g:python_recommended_style = 0

" Enable syntax highlighting.
syntax on

" Enable indenting plugin based on file type.
filetype indent plugin on

" Set status line format.
set statusline=%F%m%r%h%w,\ %{&ff},\ %Y%=char:\%b,0x\%02.2B\ -\ pos:\%l,%v\ -\ %p%%\ of\ %L\ lines 

" Automatically set working directory to be the same as the current buffer.
autocmd BufEnter * lcd %:p:h

" All temporary files share the same directory.
" set dir=$TEMP

" Disable backup.
set nobackup

" Default to UNIX file format.
set fileformats=unix,dos

colorscheme desert
hi StatusLine guibg=Black guifg=Yellow | hi StatusLineNC guibg=DarkGray guifg=Gray
set guifont=consolas:h14
set tabstop=2
set sw=2
set wrap
set textwidth=0
set nocursorline
set nocursorcolumn
set laststatus=2
set switchbuf=usetab
set updatetime=500
set visualbell
set foldmethod=marker

" Highlight wrap column.
let &colorcolumn=join(range(wrap_col + 1,wrap_col + 1),",")

" Also perform all yank operation in the system clipboard.
set clipboard=unnamed

" Turn on magic mode in patterns.
set magic

" Customize GUI.
function MyTabLine()
	let s = '' " complete tabline goes here
	" loop through each tab page
	for t in range(tabpagenr('$'))
		" set highlight
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		" set the tab page number (for mouse clicks)
		let s .= '%' . (t + 1) . 'T'
		let s .= ' '
		" set page number string
		let s .= t + 1 . ' '
		" get buffer names and statuses
		let n = ''      "temp string for buffer names while we loop and check buftype
		let m = 0       " &modified counter
		let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
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
			let s .= '[' . m . '+]'
		endif
		" select the highlighting for the buffer names
		" my default highlighting only underlines the active tab
		" buffer names.
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		" add buffer names
		if n == ''
			let s.= '[New]'
		else
			let s .= n
		endif
		" switch to no underlining and add final space to buffer list
		let s .= ' '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLineFill#%999Xclose'
	endif
	return s
endfunction

set guitablabel=%!MyTabLine()
set tabline=%!MyTabLine()

" Status line: full path, modified, help tag, preview tag, line ending, file
" type, ASCII/HEX value, position, percentage, total lines.
set statusline=%F%m%r%h%w,\ %{&ff},\ %Y%=char:\%b,0x\%02.2B\ -\ pos:\%l,%v\ -\ %p%%\ of\ %L\ lines 

" Hide menu and toolbar.
set guioptions=erL

" =====================================
" Taglist'S CUSTOMIZATIONS
" =====================================
if has("win32")
	let Tlist_Ctags_Cmd = "\"".vimfiles."\\bin\\ctags\""
endif
let Tlist_Display_Prototype = 0
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Sort_Type = "name"
let Tlist_Show_One_File = 1
let Tlist_Auto_Update = 1
let Tlist_Compact_Format = 1
let Tlist_Close_On_Select = 1
let Tlist_Display_Prototype = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Highlight_Tag_On_BufEnter = 1

" Toggle taglist window by <TAB> key or 'tl' sequence.
noremap <TAB> :TlistToggle<CR>
noremap tl :TlistToggle<CR>

if !exists("autocmd_taglist_update")
	let autocmd_taglist_update = 1
	autocmd BufWritePost * TlistUpdate
endif

" Unset smartindent for Python file.
au! FileType python setl nosmartindent

" Auto-detect Pawn file.
au BufRead,BufNewFile *.sma setfiletype pawn
" Taglist setting for Pawn file.
let tlist_pawn_settings="Pawn;m:Macro;v:Variable;f:Function"

" Auto-detect SQL file.
au BufRead,BufNewFile *.sql setfiletype sql
" Taglist setting for Pawn file.
let tlist_mysql_settings="mysql;t:Table;f:Function;p:Procedure;v:View;r:Trigger"

" Auto-detect Arduino files (use C++ syntax).
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" =====================================
" EnhCommentify'S CUSTOMIZATIONS
" =====================================
let g:EnhCommentifyRespectIndent = 'yes'
let g:EnhCommentifyPretty = 'yes'
let g:EnhCommentifyMultiPartBlocks = 'yes'

" =====================================
" UZI'S CUSTOMIZATIONS
" =====================================
" Insert a function header by typing "<Leader>fh" or ":Fh".
" The associated macro will:
" 1. Mark the current line to marker "z".
" 2. Copy the function name (under the cursor) into register "z".
" 3. Invoke this function.
" 4. Set insert mode at the DESC line.
function! UziAddFunctionHeader()
	let l:func_name = expand("<cword>")
	call append(line(".") - 1, '/* -----------------------------------------------------------------------------')
	call append(line(".") - 1, 'NAME: '.l:func_name)
	call append(line(".") - 1, 'AUTHOR: Phuong Vu (tariusagi@gmail.com)')
	call append(line(".") - 1, 'INPUT: ')
	call append(line(".") - 1, 'OUTPUT: ')
	call append(line(".") - 1, 'DESCRIPTION:')
	let l:desc_line = line(".")
	call append(line(".") - 1, "")
	call append(line(".") - 1, '----------------------------------------------------------------------------- */')
	call cursor(l:desc_line, 1)
endfunction

command! -nargs=0 Fh call UziAddFunctionHeader()
noremap <Leader>fh :call UziAddFunctionHeader()<CR>i

" Highlight my stuffs.
function! UziSyntax()
	syn match cUziComment ~// Uzi:.*$~
	syn cluster cCommentGroup add=cUziComment
	hi link cUziComment Todo
endfunction
au Syntax c call UziSyntax()
au Syntax cpp call UziSyntax()

" Substitute words globally.
" To use the word under the cursor as source, run this command:
" 	:Sw new
" To replace the first word with the second, run this command:
" 	:Sw old new
" NOTE: If the second or third arguments is "*", then this function will affect 
" all buffers, ex:
" 	:Sw new *
" 	:Sw old new *
function! UziSubstWords(...)
	" Check number of arguments...
	if a:0 < 1 || a:0 > 3
		echoerr 'UziSubstWords: only supports 1 to 3 arguments.'
		return
	endif

	" Default to process only current buffer.
	let l:allBuf = 0
	let l:currentBuf = bufnr('%')
	let l:currentLine = line('.')

	" Now get the arguments...
	" Only one argument? Then use the word under cursor as the source.
	if a:0 == 1
		let l:oldWord = expand("<cword>")
		let l:newWord = a:1
	" Two arguments? Check the second one... 
	elseif a:0 == 2
		" It's a wildcard! Then use the word under cursor as the source...
		" ...and note that we will do all buffers.
		if a:2 == '*'
			let l:oldWord = expand("<cword>")
			let l:newWord = a:1
			let l:allBuf = 1
		" No, it's not a wildcard. Then use it as the new word.
		else
			let l:oldWord = a:1
			let l:newWord = a:2
		endif
	else
		if a:3 == "*"
		" Has 3 arguments and the third one is a wildcard? It's obvious!
			let l:oldWord = a:1
			let l:newWord = a:2
			let l:allBuf = 1
		else
			echoerr 'UziSubstWords: 3rd argument should be "*".'
			return
		endif
	endif

	if l:allBuf
		" Process all buffers.
		exe 'bufdo %s/\m\<'.l:oldWord.'\>/'.l:newWord.'/eg|up'
		exe 'b '.l:currentBuf.'|'.l:currentLine
		echo 'UziSubstWords: replaced "'.l:oldWord.'" with "'.l:newWord.'" in all buffers.'
	else
		" Process current buffer only.
		exe '%s/\m\<'.l:oldWord.'\>/'.l:newWord.'/eg'
		exe currentLine
		echo 'UziSubstWords: replaced "'.l:oldWord.'" with "'.l:newWord.'".'
	endif
endfunction

" Map command "Sw" to the desired function.
command! -nargs=* Sw call UziSubstWords(<f-args>)

" Type "fs" in command mode to format current buffer using astyle.
if has("win32")
	let astyle = vimfiles."\\bin\\astyle.exe"
else
	let astyle = "astyle"
endif
cnoremap fs exe '%!"'.astyle.'" --options="'.vimfiles.'\astylerc"'<CR>:echo "INFO: current buffer has just been formatted with AStyle"<CR>

" Type <Leader>t in normal mode to toggle showing tabs.
set listchars=tab:\|>
noremap <Leader>t :set list!<CR>

" Support Ctrl-C, Ctrl-V copy & paste in Visual and Select mode.
vnoremap <C-C> "*y
vnoremap <C-V> "*p

