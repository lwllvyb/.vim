let g:ycm_python_binary_path = 'python3'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'    "此处是全局配置文件路径  
let g:ycm_confirm_extra_conf = 0                            "关闭每次导入配置文件前的询问  
let g:syntastic_always_populate_loc_list = 1                "方便使用syntastic进行语法检查  
let g:ycm_seed_identifiers_with_syntax=1                    " 开启语法关键字补全  
let g:ycm_auto_trigger = 1                                  " . :: -> 自动触发补全
let g:ycm_filetype_whitelist = { '*': 1 }                   "启用ycm的文件类型白名单
"let g:ycm_filetype_blacklist = { '*': 1 }                  "禁用ycm的文件类型黑名单
