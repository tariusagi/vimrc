" Vim compiler file
" Compiler:		amxc - AMX Mod X Compiler
" Maintainer:	Luu Phuong Vu (vuluuphuong@gmail.com)
" Last Change:	2007 Nov 30

if exists("current_compiler")
  finish
endif
let current_compiler = "amxc"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" A workable errorformat for Borland C
CompilerSet errorformat=%f(%l)\ :\ %n:%m

" default make
CompilerSet makeprg=amxxpc\ %
