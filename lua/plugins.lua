vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

use 'wbthomason/packer.nvim'
use 'mattn/emmet-vim' 
use 'jiangmiao/auto-pairs' 
use 'tpope/vim-fugitive' 
use 'tpope/vim-surround'
use 'alvarosevilla95/luatab.nvim'

use 'williamboman/mason.nvim' -- manage external editor tooling :Mason
use 'williamboman/mason-lspconfig.nvim' 
use 'neovim/nvim-lspconfig' -- LSP

use 'hrsh7th/nvim-cmp'      -- auto complete
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-nvim-lsp-signature-help'
use 'L3MON4D3/LuaSnip'
use 'saadparwaiz1/cmp_luasnip'

-- use 'dense-analysis/ale'

-- schemes
use 'sainnhe/sonokai' 
use 'sainnhe/gruvbox-material'

-- need nerdfonts
use {
    'nvim-lualine/lualine.nvim',
    'kyazdani42/nvim-web-devicons',
    opt = true,
}    

use {
    'preservim/nerdtree',
    'ryanoasis/vim-devicons'
}

use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
}

use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
}

use {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {}
  end
}

end)
