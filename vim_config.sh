#!/bin/bash

VIMRC="$HOME"/.vimrc
pkg_mgr="$1"

echo -e '\nInstalling Vim...'
sudo "$pkg_mgr" -y install vim{,-fugitive}

echo -e '\nConfiguring Vim...'
touch "$VIMRC"
echo 'set nocompatible' >> "$VIMRC"
echo 'set tabstop=4' >> "$VIMRC"
echo 'set shiftwidth=4' >> "$VIMRC"
echo 'set autoindent' >> "$VIMRC"
echo '"set smartindent' >> "$VIMRC"
echo 'syntax on' >> "$VIMRC"
echo 'set hlsearch' >> "$VIMRC"
echo 'set incsearch' >> "$VIMRC"
echo 'set number' >> "$VIMRC"
echo 'set title titlestring=%F' >> "$VIMRC"
echo 'set scrolloff=5' >> "$VIMRC"
echo 'set splitbelow' >> "$VIMRC"
echo 'set splitright' >> "$VIMRC"
echo >> "$VIMRC"
echo '" Enable folding' >> "$VIMRC"
echo 'augroup filetype_vim' >> "$VIMRC"
echo -e '\tautocmd!' >> "$VIMRC"
echo -e '\tautocmd FileType vim setlocal foldmethod=marker' >> "$VIMRC"
echo 'augroup END' >> "$VIMRC"
echo >> "$VIMRC"
echo '" Status line info' >> "$VIMRC"
echo 'set statusline=' >> "$VIMRC"
echo 'set statusline+=\ %t\ %M\ %Y\ %R' >> "$VIMRC"
echo 'set statusline+=%=' >> "$VIMRC"
echo 'set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%' >> "$VIMRC"
echo 'set laststatus=2' >> "$VIMRC"
echo >> "$VIMRC"
echo 'nmap <silent> <A-Up> :wincmd k<CR>' >> "$VIMRC"
echo 'nmap <silent> <A-Down> :wincmd j<CR>' >> "$VIMRC"
echo 'nmap <silent> <A-Left> :wincmd h<CR>' >> "$VIMRC"
echo 'nmap <silent> <A-Right> :wincmd l<CR>' >> "$VIMRC"
echo >> "$VIMRC"
echo '" Enable full LaTeX usability' >> "$VIMRC"
echo 'filetype plugin on' >> "$VIMRC"
echo 'set grepprg=grep\ -nH\ $*' >> "$VIMRC"
echo 'filetype indent on' >> "$VIMRC"
echo "let g:tex_flavor='latex'">> "$VIMRC"
echo >> "$VIMRC"

sudo cp "$VIMRC" /root/
