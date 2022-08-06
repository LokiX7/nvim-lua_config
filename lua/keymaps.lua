local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
local opts = {noremap = true, silent=true}

-- Буфер обмена
-- sudo apt install xclip если не работает 
map("i", "<c-v>", '"+pa', opts)
map("v", "<c-c>", '"+y', opts)
map("v", "<c-d>", '"+d', opts)

-- Отключить подсветку поиск при нажатии space 
map('n', '<space>', ':nohlsearch<CR>', opts)

-- jk как esc
map('i', 'jk', '<esc>', opts)

-- NerdTree keys
map('n', '<C-n>', ':NERDTreeToggle<CR>', opts)                                                   
map('n','<Cj>',  '<Cw> j', opts)                                                           
map('n', '<Ck>', '<Cw> k', opts)                                                           
map('n', '<Cl>', '<Cw> l', opts)                                                           
map('n', '<Ch>', '<Cw> h', opts)

-- Telescope keys
map('n', 'ff', '<cmd>Telescope find_files<cr>', opts)
map('n', 'fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', 'fb', '<cmd>Telescope buffers<cr>', opts)
map('n', 'fh', '<cmd>Telescope help_tags<cr>', opts)
