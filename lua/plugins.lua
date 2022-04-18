vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
use 'wbthomason/packer.nvim'
use 'mattn/emmet-vim' 
use 'jiangmiao/auto-pairs' 
use 'dense-analysis/ale' 
use 'sainnhe/sonokai' 
use 'vim-airline/vim-airline' 
use 'preservim/nerdtree' 
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate'
}
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
end)
