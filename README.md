
## Install

1. Execute `git submodule init` under the project directory
2. Execute `:DeinInstall` in vim
3. Restart vim

## Keymapping

### Normal

* 折叠代码 ----------- `<c-j>`
* EasyMotion-jk ------ `<m-n>`
* EasyMotion-bd-w ---- `<m-;>`
* 使当前行在屏幕中间/屏幕上方 - `<c-l>`

### Insert

* 光标
  - 上、下、左、右 --------- `<c-p>` `<c-n>` `<c-b>` `<c-f>`
  - 移至行首、行尾 --------- `<c-a>` `<c-e>`
  - 左移单词、右移单词 ----- `<m-b>` `<m-f>`
* 删除
  - 至行首、行尾 --------- `<c-u>` `<c-k>`
  - 前/后一个字符 -- `<c-h>`/`<c-d>`
  - 前/后一个单词 -- `<c-w>`/`<m-d>`

* 补全代码 ------------- `<m-/>`
* 补全/展开**代码片段** ---- `<c-\>`
* 缩进/反缩进 ---------- `<m-]>`/`<m-[>`
* 使当前行在屏幕中间/屏幕上方 - `<c-l>`

## ctags

* Windows: `mklink %USERPROFILE%\.ctags _ctags`
* Linux: `ln -s _ctags ~/.ctags`
