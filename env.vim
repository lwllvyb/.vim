" =============================================================================
" Filename:     env.vim
" Author:       luzhlon
" Description:  vim's environment variable
" Last Change:  2017/2/20
" =============================================================================

let s:local_conf = glob('~/.vimenv')      "本地的vim环境变量配置文件

if filereadable(s:local_conf)
    exe 'so' s:local_conf
endif
