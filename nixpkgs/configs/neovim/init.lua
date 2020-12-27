vim.cmd([[
call plug#begin($HOME.'/.neovim/plugged')

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'jpalardy/vim-slime'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'haorenW1025/completion-nvim'
Plug 'sbdchd/neoformat'

call plug#end()
]])

--Allow filetype plugins and syntax highlighting
vim.o.autoindent = true
-- TODO: replace with lua
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

--Expand tab to spaces
vim.o.expandtab = true

--Incremental live completion
vim.o.inccommand = "nosplit"

--Change backspace to behave more intuitively
vim.o.backspace = "indent,eol,start"

--Set tab options for vim
vim.o.tabstop = 8
vim.o.softtabstop = 4

--Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Set show command
vim.o.showcmd = true

--Save undo history
vim.o.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn="yes"

--Set colorscheme
vim.o.termguicolors = true
-- TODO: replace with lua
vim.cmd([[colorscheme onedark]])
vim.g.onedark_terminal_italics = 2

--Set statusbar
vim.g.lightline = { colorscheme = 'onedark';
       active = {
         left = { { 'mode', 'paste' },
         { 'gitbranch', 'readonly', 'filename', 'modified' } }
       };
       component_function = {
         gitbranch = 'fugitive#head',
       };
}

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true})
-- TODO: Fix leader mapping
vim.g.mapleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true })

--Add move line shortcuts
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true})
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', { noremap = true})
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', { noremap = true})

--Remap escape to leave terminal mode
vim.cmd [[
        augroup Terminal
          au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
          au FileType fzf tunmap <buffer> <Esc>
        augroup end
]]

--Add map to enter paste mode
vim.o.pastetoggle="<F3>"


-- TODO: Broken, replace with lua
vim.cmd([[
"Allow copy and paste to clipboard
nnoremap <F10> :call ToggleMouse()<CR>

function! ToggleMouse()
  if &mouse == 'a'
    IndentLinesDisable
    set signcolumn=no
    set mouse=v
    set nonu
    echo "Mouse usage Visual"
  else
    IndentLinesEnable
    set signcolumn=yes
    set mouse=a
    set nu
    echo "Mouse usage All"
  endif
endfunction
]])

--Start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

--Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

--Add neovim remote for vimtex
vim.g.vimtex_compiler_progname = 'nvr'
vim.g.tex_flavor = 'latex'

-- Intelligent switching of branches
-- TODO: Broken, replace with lua
vim.cmd([[
function! GitCheckoutRef(ref)
    execute('Git checkout ' . a:ref)
    call feedkeys("i")
endfunction

function! GitListRefs()
   let l:refs = execute("Git for-each-ref --format='\\%(refname:short)'")
   return split(l:refs,'\r\n*')[1:] "jump past the first line which is the git command
endfunction

command! -bang Gbranch call fzf#run({ 'source': gitListRefs(), 'sink': function('GitCheckoutRef'), 'dir':expand('%:p:h') })
]])

-- Search project root
-- Add command for searching files within current git directory structure
-- TODO: Broken, replace with lua
vim.cmd([[
function! Find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(options), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

command! ProjectFiles execute 'Files' Find_git_root()
]])

-- Projects implementation
-- TODO: Broken, replace with lua
vim.cmd([[
function! Switch_projects(path)
  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:path[0], 'e')

  execute cmd escape(a:path[1], ' %#\')
  execute('lcd ' . a:path[1])
endfunction

command! -nargs=* Projects call fzf#run({
\ 'source':  'fd -H -t d --maxdepth 4 .git ' . $HOME . "/Repositories" . ' | sed -En "s/\/.git//p"',
\ 'sink*':    function('Switch_projects'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'})
]])

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>f', ':ProjectFiles<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><space>', ':Buffers<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>A', ':Windows<CR>', { noremap = true, silent = true})
-- TODO: Broken
vim.api.nvim_set_keymap('n', '<leader>l', ':BLines<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>o', ':BTags<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>t', ':Tags<CR>', { noremap = true, silent = true})
-- TODO: Broken
vim.api.nvim_set_keymap('n', '<leader>?', ':History<CR>', { noremap = true, silent = true})

-- TODO: Broken
vim.api.nvim_set_keymap('n', '<leader>s', ':Rg<CR>', { noremap = true, silent = true})
-- TODO: Broken
vim.api.nvim_set_keymap('n', '<leader>p', ':Projects<CR>', { noremap = true, silent = true})

-- Add Fugitive shortcuts
vim.api.nvim_set_keymap('n', '<leader>gc', ':Commits<CR>', { noremap = true, silent = true})
-- TODO: Broken
vim.api.nvim_set_keymap('n', '<leader>gb', ':Gbranch<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add %:p<CR><CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Gstatus<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ge', ':Gedit<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR><CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':silent! Glog<CR>:bot copen<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', ':Ggrep<Space>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gm', ':Gmove<Space>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>go', ':Git checkout<Space>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gps', ':Dispatch! git push<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gpl', ':Dispatch! git pull<CR>', { noremap = true, silent = true})

-- alternative shorcuts without fzf
vim.api.nvim_set_keymap('n', '<leader>,', ':buffer *', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>.', ':e<space>**/', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>T', ':tjump *', { noremap = true})

-- Make gutentags use ripgrep
-- --python-kinds=-iv
-- --exclude=build
-- --exclude=dist
vim.g.gutentags_file_list_command = 'fd'
vim.g.gutentags_ctags_extra_args = { '-n', '-u', '--python-kinds=-iv' }

-- speed up indent line
-- default ''.
-- n for Normal mode
-- v for Visual mode
-- i for Insert mode
-- c for Command line editing, for 'incsearch'
vim.g.indentLine_faster = 1
vim.g.indentLine_setConceal = 2
vim.g.indentLine_concealcursor = ""
vim.g.indentLine_bufNameExclude = { "term:.*" }

-- remove conceal on markdown files
vim.g.markdown_syntax_conceal = 0

-- Configure vim slime to use tmux
vim.g.slime_target = "tmux"
vim.g.slime_python_ipython = 1
vim.g.slime_dont_ask_default = 1
vim.g.slime_default_config = {socket_name = "default", target_pane = "{right-of}"}

-- Change preview window location
vim.g.splitbelow = true

-- Remap number increment to alt
vim.api.nvim_set_keymap('n', '<A-a>', '<C-a>', { noremap = true})
vim.api.nvim_set_keymap('v', '<A-a>', '<C-a>', { noremap = true})
vim.api.nvim_set_keymap('n', '<A-x>', '<C-x>', { noremap = true})
vim.api.nvim_set_keymap('v', '<A-x>', '<C-x>', { noremap = true})

-- n always goes forward
-- TODO: Broken
-- vim.api.nvim_set_keymap('n', '<expr> n', '\'Nn\'[v:searchforward]', { noremap = true})
-- vim.api.nvim_set_keymap('x', '<expr> n', '\'Nn\'[v:searchforward]', { noremap = true})
-- vim.api.nvim_set_keymap('o', '<expr> n', '\'Nn\'[v:searchforward]', { noremap = true})
-- vim.api.nvim_set_keymap('n', '<expr> N', '\'nN\'[v:searchforward]', { noremap = true})
-- vim.api.nvim_set_keymap('x', '<expr> N', '\'nN\'[v:searchforward]', { noremap = true})
-- vim.api.nvim_set_keymap('o', '<expr> N', '\'nN\'[v:searchforward]', { noremap = true})

vim.cmd([[
  nnoremap <expr> n  'Nn'[v:searchforward]
  xnoremap <expr> n  'Nn'[v:searchforward]
  onoremap <expr> n  'Nn'[v:searchforward]

  nnoremap <expr> N  'nN'[v:searchforward]
  xnoremap <expr> N  'nN'[v:searchforward]
  onoremap <expr> N  'nN'[v:searchforward]
]])


-- Neovim python support
vim.g.loaded_python_provider = 0

-- Highlight on yank
vim.cmd([[
au TextYankPost * silent! lua vim.highlight.on_yank()
]])

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Clear white space on empty lines and end of line
-- vim.api.nvim_set_keymap('n', '<F6>', ':let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>', { noremap = true, silent = true})

-- Nerdtree like sidepanel
-- absolute width of netrw window
vim.g.netrw_winsize = -28

-- do not display info on the top of window
vim.g.netrw_banner = 0

-- sort is affecting only: directories on the top, files below
-- vim.g.netrw_sort_sequence = '[\/]$,*'

-- variable for use by ToggleNetrw function
vim.g.NetrwIsOpen = 0

-- Lexplore toggle function
-- TODO: replace with lua
vim.cmd([[
function! ToggleNetrw()

    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
        let g:netrw_liststyle = 0
        let g:netrw_chgwin=-1
    else
        let g:NetrwIsOpen=1
        let g:netrw_liststyle = 3
        silent Lexplore
    endif
endfunction

noremap <silent> <leader>d :call ToggleNetrw()<CR><Paste>
]])

-- Function to open preview of file under netrw
-- TODO: replace with lua
vim.cmd([[
augroup Netrw
  autocmd filetype netrw nmap <leader>; <cr>:wincmd W<cr>
augroup end
]])

-- Vim polyglot language specific settings
vim.g.python_highlight_space_errors = 0

-- LSP settings
-- log file location: /Users/michael/.local/share/nvim/vim-lsp.log
-- Add nvim-lspconfig plugin
local nvim_lsp = require('lspconfig')
-- vim.lsp.set_log_level("debug")
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- disable virtual text
      virtual_text = false,

      -- show signs
      signs = true,

      -- delay update diagnostics
      update_in_insert = false,
    }
  )
  require'completion'.on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local servers = {'gopls', 'rust_analyzer', 'tsserver', 'vimls', 'jsonls', 'html', 'ghcide', 'rnix', 'ocamllsp', 'pyright'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

-- TODO: replace with lua
vim.cmd([[
command! Format  execute 'lua vim.lsp.buf.formatting()'
]])

-- Use <Tab> and <S-Tab> to navigate through popup menu
-- TODO: replace with lua
vim.cmd([[
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]])

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Chain completion list
vim.g.completion_chain_complete_list = {
            default = {
              default = {
                  { complete_items = { 'lsp', 'snippet' }},
                  { mode = '<c-p>'},
                  { mode = '<c-n>'}},
              comment = {},
              string = { { complete_items = { 'path' }} }}}


-- Formatters 
vim.g.neoformat_enabled_python = { 'black' }
