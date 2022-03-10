colorscheme sonokai
set background=dark

syntax enable
set sw=2
set expandtab
set softtabstop=2
set smarttab
set autoindent
set smartindent
set tabstop=2
set smartindent
set noswapfile
set ruler
set nowrap
set linebreak
" set textwidth=80
set nocompatible
set nobackup
set nowritebackup
set whichwrap+=<,>,[,]
set scrolloff=6
set list
set listchars=eol:$,tab:>.
let &t_Co=256
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file
set laststatus=2
set colorcolumn=80
set cursorline
set number
set relativenumber

filetype on
autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
autocmd BufNewFile,BufRead *.wiki set syntax=markdown
autocmd BufNewFile,BufRead *.bats set syntax=bash
autocmd FileType rust set sw=4
autocmd FileType rust set softtabstop=4
autocmd FileType rust set tabstop=4
autocmd FileType go setlocal noexpandtab
set splitbelow
set splitright
set mouse=a
set autoread

"
" Golang-specific stuff
"

let g:go_fmt_autosave = 1
filetype plugin indent on
" why do i need this when i have the above?
au BufWritePre,FileWritePre *.go :GoFmt

"
" Install plugins for LSP
"

call plug#begin('~/.config/nvim/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

call plug#end()

"
" Settings for a better Rust experience
" From: https://github.com/sharksforarms/vim-rust/blob/master/neovim-init-lsp.vim
"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c


" Configure lsp
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    capabilities=capabilities,
    on_attach=on_attach
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" rust-analyzer does not yet support goto declaration
" re-mapped `gd` to definition
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>f     <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>

" Trigger completion with <tab>
" found in :help completion
" Use <Tab> and <S-Tab> to navigate through popup menu
" LB: disabled, i don't want this
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

nnoremap <leader>d     <cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Enable type inlay hints
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
autocmd BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 500)
