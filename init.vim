call plug#begin('~/.config/nvim/plugins')

" Themes/look and feel
"Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/rakr/vim-one'

"Nerdtree
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/ryanoasis/vim-devicons'
"Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight'
"
" Nice to have
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/tpope/vim-surround'
"Git integration
Plug 'https://github.com/tpope/vim-fugitive'
"Search/replace
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/brooth/far.vim'

"Language stuff
"
"Golang
Plug 'https://github.com/fatih/vim-go'
Plug 'https://github.com/buoto/gotests-vim'

Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
"
" Nerdtree
nmap ,m :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
let NERDTreeShowHidden=1 "Show hidden files(starting with a .)
" When exiting vim if nerdtree is the last window open close it automatically
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Cleaner UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Automatically close nerdtree if vim args == 0
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"FZF
" Tell FZF to use RG - so we can skip .gitignore files even if not using
" :GitFiles search
"let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" If you want gitignored files:
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-vcs --hidden -F'
nmap <C-p> :Files<CR>
"ultisnips
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

"Far
let g:far#source = "rgnvim"

" Theme begin
"set background=dark
"colorscheme palenight
"let g:palenight_terminal_italics=1
"let g:airline_theme = "palenight"

colorscheme one
let g:one_allow_italics = 1
set background=dark
"let g:airline_theme='onedark'
"colorscheme onedark

syntax on

"Practial
"Dim unfocuses window
"hi ActiveWindow ctermbg=None ctermfg=None guibg=#21242b
"hi InactiveWindow ctermbg=darkgray ctermfg=gray guibg=#282c34
"set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

"Flashy transparency :) make sure you terminal follows along
hi Normal guibg=NONE ctermbg=NONE

"Fix colors when using tmux
if (has("termguicolors"))
  set termguicolors
endif

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"make cursor blink
set guicursor=a:blinkon100
" Theme end
"
set spelllang=en_gb,sv

"Disable Ex mode
map Q <nop>

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

nnoremap <SPACE> <Nop>
let mapleader=" "

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults :)
set splitbelow splitright

"Make VIM and X11 share the came clipboard
set clipboard+=unnamedplus

set completeopt+=preview
"set completeopt=longest,menuone

filetype on "detect files bases on type
filetype plugin on "when a file is edited its plugin file is loaded(if there is one)
filetype indent on "maintain indentation

set tabstop=4      " To match the sample file
set noexpandtab    " Use tabs, not spaces
set nowrap "dont wrap lines visually
set number relativenumber "Relative linenumber and absolut linenumber where the cursor currently is
set list	" Shows whitespace as a character
set listchars=eol:¬,tab:>\ ,space:·
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4	" Make tabbing 4 spaces wide
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set path+=** "Enables recusive :find for example
set ignorecase

set undodir=~/.cache/nvim_undo
set undofile

" Set custom settings based on file extension
autocmd FileType dart setlocal shiftwidth=2 softtabstop=2 expandtab

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

"replace currently selected text with default register
"without yanking it
"vnoremap <leader>p _dP
"replace with Register 0
map <leader>rr ciw<C-r>0<Esc>

" quicker access
"map <space> :

" Custom keybinding of native features
nnoremap <F1> :Buffers<CR><Space>

"Clears highlighted
nnoremap <CR> :noh<CR>

"Keybinding to toggle syncronization of window scrolling
map <leader>S :windo set scb!<CR>

"Keybinding to refresh vim config
nnoremap <F12> :source ~/.config/nvim/init.vim <CR>

"Sweet way of previewing markdown
map <leader>ö :execute
			\ '!mkdir -p $HOME/tmp && pandoc --from=gfm % -o $HOME/tmp/nvim-markdown.pdf && (xdg-open $HOME/tmp/nvim-markdown.pdf ) 2> /dev/null & '<enter> | redraw!


" visual shifting and keep visual selection
vnoremap < <gv
vnoremap > >gv

"make Y behave like D and C
nnoremap Y y$

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"Ignore filepaths when fuzzy finding
set wildignore+=**/node_modules/**
set wildignore+=**/vendor/**

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-W>o :ZoomToggle<CR>

"improve default gx command by opening the URL/filepath in the background instead. This way we dont lock the old window.
nnoremap gx :execute
            \ "!xdg-open" expand("<cfile>")" &"<cr>

noremap <Leader><space> :update<CR>

" Some sweet macros!
" PHP
"replace PHP array() to []
let @p='/\<array\>(dema%r]``ar['

" vim-go conf
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
"more colors
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_format_strings = 1

let g:go_fmt_command = "goimports" "Auto import packages

"let g:go_gopls_enabled = 0
"let g:go_code_completion_enabled = 0
"let g:go_auto_sameids = 0
"let g:go_fmt_autosave = 0
"let g:go_def_mapping_enabled = 0
"let g:go_diagnostics_enabled = 0
"let g:go_echo_go_info = 0
"let g:go_metalinter_enabled = 0








"Coc Conf

" sets up command to run prettier automatically
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

let g:coc_global_extensions = [
			\'coc-json',
			\'coc-css',
			\'coc-html',
			\'coc-yaml',
			\'coc-tsserver',
			\'coc-vetur',
			\'coc-eslint',
			\'coc-pairs',
			\'coc-prettier',
			\'coc-rust-analyzer',
			\'coc-pyright'
			\]
"
" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
au BufRead,BufNewFile *.tmpl set filetype=html
"
"
" COPY PASTA FROM https://github.com/neoclide/coc.nvim

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

