
if has('win32')
    let g:vimrc_dir = $USERPROFILE . '\vimfiles'
else
    let g:vimrc_dir = $HOME . '/.vim'
endif

exec ':set runtimepath^=' . g:vimrc_dir
let &packpath = &runtimepath

if has("win32")
    let g:ruby_host_prog = 'C:\Ruby22-x64\lib\ruby\gems\2.2.0\gems\neovim-0.7.1\bin\neovim-ruby-host'
end

exec ':source ' . g:vimrc_dir . '/vimrc'
