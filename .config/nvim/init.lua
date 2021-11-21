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

--My configs
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.colorcolumn = "120"
vim.wo.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.confirm = true
vim.o.title = true
vim.o.titlestring = "%{join(split(getcwd(), '/')[-2:], '/')}"
vim.o.clipboard = "unnamedplus"
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.inccommand = 'nosplit'
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.encoding = 'UTF-8'
vim.o.autoread = true
vim.opt.undofile = true
vim.opt.syntax = 'enable'

-- Style
vim.o.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd('colorscheme NeoSolarized')
vim.cmd[[au VimEnter * hi Normal guibg=NONE ctermbg=NONE]]

--Set statusbar
vim.g.lightline = {
 colorscheme = 'solarized',
 active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
 component_function = { gitbranch = 'fugitive#head' },
}

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
