-- Author: Gabriel Caussi
-- Source: https://github.com/gabrielcaussi/dotfiles

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
      },
    }
  }

  use 'tpope/vim-commentary'
  use 'overcache/NeoSolarized'
  use 'itchyny/lightline.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }
end)

-- My configs
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.colorcolumn = "120"
-- vim.wo.signcolumn = 'no'
vim.o.cursorline = true
vim.o.wrap = false
vim.o.confirm = true
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = false
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.inccommand = 'nosplit'
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 750
vim.o.encoding = 'UTF-8'
vim.o.autoread = true
vim.g.scrolloff = 5
vim.opt.undofile = true
vim.opt.syntax = 'enable'
vim.cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

-- Theme
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd('let g:neosolarized_termtrans=1')
vim.cmd('let g:neosolarized_bold = 1')
vim.cmd('let g:neosolarized_underline = 1')
vim.cmd('let g:neosolarized_italic = 1')
vim.cmd('let g:neosolarized_termBoldAsBright = 1')
vim.cmd('colorscheme NeoSolarized')
vim.cmd[[au VimEnter * highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=#Grey40]]

-- Statusbar
vim.g.lightline = {
 colorscheme = 'solarized',
 active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
 component_function = { gitbranch = 'fugitive#head' },
}

-- Blankline
-- vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Keyboard Shortcuts
vim.cmd[[let mapleader="\<space>"]]
vim.cmd('nnoremap <leader>v :vsplit<CR>')
vim.cmd('nnoremap <leader>h :split<CR>')
vim.cmd('nnoremap <leader>; A;<ESC>')
vim.cmd('nnoremap <c-b> <ESC>:NvimTreeToggle<CR>')
vim.cmd('map ; gc')
