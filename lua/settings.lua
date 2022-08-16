local api = vim.api
local cmd = vim.cmd                 -- execute Vim commands
local exec = api.nvim_exec          -- execute Vimscript
local g = vim.g                     -- global variables
local opt = vim.opt                 -- global/buffer/windows-scoped options
local wo = vim.wo


-- Главные --------------------------------------------------------------------

exec ('language en_US.UTF-8', true)
opt.expandtab = true                -- Настройка табов
opt.smarttab = true                 -- При нажатии таба в начале строки добавляет количество пробелов равное shiftwidth.
opt.tabstop=4                       -- Количество пробелов в табе                                      
opt.softtabstop=4                   -- Количество пробелов в табе при удалении                     
opt.shiftwidth=4                                                               
opt.scrolloff=7                     -- Скролл на n строк
opt.colorcolumn = '80'              -- Разделитель на 80 символов
opt.number = true                   -- Включаем нумерацию строк
<<<<<<< HEAD
--opt.relativenumber = true           -- Вкл. относительную нумерацию строк
=======
>>>>>>> new_lsp
opt.mouse ='a'                      -- Включить мышь
opt.showtabline=1                   -- Вырубаем черточки на табах
opt.wrap = true                     -- Переносим на другую строчку, разрываем строки
opt.linebreak = true
opt.backup = false                  -- Вырубаем .swp и ~ (резервные) файлы
opt.swapfile = false
opt.encoding ='utf-8'               -- Кодировка файлов и терминала
opt.fileencodings ='utf8','cp1251'
opt.termencoding ='utf-8'
opt.hlsearch = true                 -- Подсвечивать результаты поиска
opt.showcmd = true                  -- Показывать строку набора команд
opt.termguicolors = true 
opt.foldlevelstart = 20             -- Открывать складки при открытии файла
opt.foldmethod = 'indent'


-- С этой строкой отлично форматирует html файл, который содержит jinja2
cmd [[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-- Перед сохранением вырезаем пробелы на концах (только в .py файлах)
cmd [[ autocmd BufWritePre *.py normal m`:%s/\s\+$//e `` ]]
-- В .py файлах включаем умные отступы после ключевых слов
cmd [[ autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,match ]]
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]


-- Schemes --------------------------------------------------------------------


----------------------------- sonokai

--g.sonokai_style = 'andromeda'
--g.sonokai_transparent_background = 1
--cmd 'colorscheme sonokai'           -- Должна быть последней!


----------------------------- gruvbox-material

g.gruvbox_material_transparent_background = 1
g.gruvbox_material_foreground = 'mix'
g.gruvbox_material_enable_bold = 0
g.gruvbox_material_ui_contrast = 'high'
g.gruvbox_material_statusline_style = 'original'
cmd 'colorscheme gruvbox-material'


-- LuaLine --------------------------------------------------------------------

require('lualine').setup {
    {options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}}


-- luatab ---------------------------------------------------------------------

require('luatab').setup{
}


-- NerdTree -------------------------------------------------------------------

cmd [[
autocmd StdinReadPre * let s:std_in=1 
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
]]     


-- Mason manager --------------------------------------------------------------

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }   
})


-- CMP ------------------------------------------------------------------------

local cmp = require('cmp')

cmp.setup {
  completion = {
    autocomplete = false
  },
  
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-n>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


-- nvim-lspconfig -------------------------------------------------------------

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


  -- Init lsp 

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}




-- ALE ------------------------------------------------------------------------

--g.ale_sign_error = '✕'
--g.ale_sign_warning = '⚠'


-- TreeSitter -----------------------------------------------------------------

wo.foldexpr = 'nvim_treesitter#foldexpr()'
wo.foldcolumn = '1'

require'nvim-treesitter.configs'.setup {
  
-- A list of parser names, or "all"
ensure_installed = { 'python', 'html', 'javascript', 'css' },

-- Install parsers synchronously (only applied to `ensure_installed`)
sync_install = false,

-- List of parsers to ignore installing (for "all")
ignore_install = {},

indent = {
    enable = true
  },

highlight = {
-- `false` will disable the whole extension
enable = true,

-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
-- the name of the parser)
-- list of language that will be disabled
disable = {},

-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- Instead of true it can also be a list of languages
additional_vim_regex_highlighting = false,
  },
}

--


