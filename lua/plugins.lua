vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

use 'wbthomason/packer.nvim'
use 'mattn/emmet-vim' 
use 'jiangmiao/auto-pairs' 
use 'dense-analysis/ale'
use 'sainnhe/sonokai' 
use 'tpope/vim-fugitive' 

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
    requires = { {'nvim-lua/plenary.nvim', opt = true} }
}

end)
