
if has('win32')
    let g:vimrc_dir = $USERPROFILE . '\vimfiles'
else
    let g:vimrc_dir = $HOME . '/.vim'
endif

exec ':set runtimepath^=' . g:vimrc_dir
let &packpath = &runtimepath

exec ':source ' . g:vimrc_dir . '/vimrc'
