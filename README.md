
## Install

1. Execute `git submodule init` under the project directory
2. Execute `install.cmd` to link some configuration to home directory
3. Download the latest vim/neovim
  - https://github.com/vim/vim-win32-installer/releases
  - https://github.com/neovim/neovim/releases
4. Execute `:DeinInstall` in vim
5. Restart vim/neovim

## Keymapping

### Normal

| 功能               | 快捷键          |
| ------------------ | --------------- |
| 折叠代码           | `<c-j>`         |
| EasyMotion-jk      | `<c-k>`         |
| EasyMotion-bd-w    | `<c-h>`         |
| 前一/后一个文件    | `<m-i>`/`<m-o>` |

### Insert

| 光标移动      | 快捷键                          |
| ------------- | ------------------------------- |
| 上/下/左/右   | `<c-p>`/`<c-n>`/`<c-b>`/`<c-f>` |
| 移至行首/行尾 | `<c-a>`/`<c-e>`                 |
| 前一/后一单词 | `<m-b>`/`<m-f>`                 |

| 删除字符      | 快捷键          |
| ------------- | --------------- |
| 至行首/行尾   | `<c-u>`/`<c-k>` |
| 前/后一个字符 | `<c-h>`/`<c-d>` |
| 前/后一个单词 | `<c-w>`/`<m-d>` |

| 其他功能           | 快捷键          |
| ------------------ | --------------- |
| 补全代码           | `<m-/>`         |
| 展开代码片段       | `<c-\>`         |
| 缩进/反缩进        | `<m-]>`/`<m-[>` |

### Normal/Insert

| 功能                | 快捷键                          |
| ------------------- | ------------------------------- |
| 当前行上/中/下切换  | `<c-l>`                         |
| 移至上/下/左/右窗口 | `<m-k>`/`<m-j>`/`<m-h>`/`<m-l>` |
| 运行当前文件        | `<F5>`                          |

## External Tools

### Font

* https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf
* https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf

### Binary

* https://github.com/universal-ctags/ctags-win32/releases

### Python3

* https://www.python.org/
* `pip3 install neovim jedi pep8 pefile`
