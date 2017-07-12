" =============================================================================
" Filename:     template.vim
" Author:       luzhlon
" Description:  vim startup template
" Last Change:  2017/7/10
" =============================================================================

set pythonthreedll=python36.dll
let g:clang_library_path = ''

let s:incdirs = ['C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.10.25017/include']
let s:sdkdir = 'C:/Program Files (x86)/Windows Kits/10'
call extend(s:incdirs, glob(s:sdkdir . '/Include/*/*/',0,1))

call map(s:incdirs, {i,v->substitute(v, '\\$', '', '')})
let &path .= join(s:incdirs, ',')
let $INCLUDE = join(s:incdirs, ';')
let $C_INCLUDE_PATH = $INCLUDE
let $CPLUS_INCLUDE_PATH = $C_INCLUDE_PATH
let s:libdirs = ['C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.10.25017/lib/x64']
call extend(s:libdirs, glob(s:sdkdir . '/Lib/*/*/x64',0,1))
let $LIB = join(s:libdirs, ';')
let $LIBRARY_PATH = $LIB
let $LD_LIBRARY_PATH = $LIBRARY_PATH

" set shell=powershell.exe
" set shellcmdflag=-c
" set shellpipe=>
" set shellredir=>

so <sfile>:h/vimfiles/vimrc
set lines=35 columns=112

set bg=light
colorscheme gruvbox

au FocusLost * let @+ = @"
