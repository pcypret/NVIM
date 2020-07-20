" # Basic Settings
set autochdir					" Set path to directory of currently edited file
"autocmd BufEnter * silent! lcd %:p:h -- potential alternative to autochdir recommeded by http://vim.wikia.com/wiki/VimTip64
"set nocompatible				" vim-specific settings, non-vi-compatible
set backspace=indent,eol,start 	" Allow backspace in insert mode
syntax on
set number						" Line numbers
set laststatus=2
set wrap						" Turn on word wrapping
set linebreak					" Only wrap at sensible places
set nolist						" list disables linebreak
set textwidth=0					" prevent Vim from automatically inserting line breaks
set wrapmargin=0
set formatoptions-=t			" Don't change wrapping on existing lines
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set ruler
set viewoptions=folds,cursor
set sessionoptions=folds
set buftype=nofile              "change initial buffer to scratchpad" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"have VIM remember folds when exiting
augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NERDTree customizattions
let g:NERDTreeMapJumpParent="☻"
"let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"buftabline settings
set hidden
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set spell spelllang=en_us
"set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
" # Color Scheme
syntax on
set background=dark
set t_Co=256			" 256 colors, terrible for most themes, but best for Tomorrow-Night
colorscheme Tomorrow-Night
  let g:miniBufExplMapWindowNavVim = 1 
  let g:miniBufExplMapWindowNavArrows = 1 
  let g:miniBufExplMapCTabSwitchBufs = 1 
  let g:miniBufExplModSelTarget = 1

    nnoremap ; :
    noremap <C-Down>  <C-W>j
    noremap <C-Up>    <C-W>k
    noremap <C-Left>  <C-W>h
    noremap <C-Right> <C-W>l

filetype plugin indent on		" Enable file type detection and do language-dependent indenting.
set history=100					" Default = 8

autocmd VimEnter * NERDTree

let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
highlight User1 ctermbg=gray guibg=gray ctermfg=black guifg=black
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=
set statusline+=%1*			" Switch to User1 color highlight
set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %p%%
:set statusline+=\ -\      " Separator
set statusline+=\ %l:%c
:set statusline+=\ -\      " Separator
set statusline+=%<%F			" file name, cut if needed at start
set statusline+=%M			" modified flag
set statusline+=%=			" separator from left to right justified
set statusline+=\ (%{strftime(\"%b-%d\ %H:%M\",getftime(expand(\"%:p\")))})    "last modified timestamp
set statusline+=%{StatuslineGit()}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! WordCount()
function! WordCount()
    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            let b:wordcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        return b:wordcount
    endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" #Vim Plug Settings
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid usin
"   g standard Vim directory names like 'plugin'
call plug#begin('/usr/share/nvim/runtime/plugged/')

" Make sure you use single quotes
"Plug 'reedes/vim-wordy'
"Plug 'rhysd/vim-grammarous'
"Plug 'dbmrq/vim-ditto'
"Plug 'itchyny/lightline.vim'
Plug 'michal-h21/vim-zettel'
"Plug 'itchyny/lightline.vim'
"Plug 'reedes/vim-pencil'
Plug 'airblade/vim-gitgutter'
Plug 'blindFS/vim-taskwarrior'
Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-obsession'
Plug 'makerj/vim-pdf'
Plug 'ap/vim-buftabline'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-wordy'
Plug 'rhysd/vim-grammarous'
Plug 'dbmrq/vim-ditto'
Plug 'vimwiki/vimwiki'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vimoutliner/vimoutliner'
Plug 'scrooloose/nerdcommenter'
"R PLUGINS
Plug 'rizzatti/dash.vim'
Plug 'jalvesaq/Nvim-R'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'gaalcaras/ncm-R'
Plug 'chrisbra/csv.vim'
Plug 'w0rp/ale'
"END R PLUGINS
call plug#end() 
