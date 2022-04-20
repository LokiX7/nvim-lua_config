local api = vim.api
local cmd = vim.cmd                 -- execute Vim commands
local exec = api.nvim_exec          -- execute Vimscript
local g = vim.g                     -- global variables
local opt = vim.opt                 -- global/buffer/windows-scoped options
local wo = vim.wo


-- Главные --------------------------------------------------------------

opt.expandtab = true                -- Настройка табов
opt.smarttab = true                 -- При нажатии таба в начале строки добавляет количество пробелов равное shiftwidth.
opt.tabstop=4                       -- Количество пробелов в табе                                      
opt.softtabstop=4                   -- Количество пробелов в табе при удалении                     
opt.shiftwidth=4                                                               
opt.scrolloff=7                     -- Скролл на n строк
opt.colorcolumn = '80'              -- Разделитель на 80 символов
opt.spelllang= { 'en_us', 'ru' }    -- Словари рус eng
opt.number = true                   -- Включаем нумерацию строк
opt.relativenumber = true           -- Вкл. относительную нумерацию строк
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

-- С этой строкой отлично форматирует html файл, который содержит jinja2
cmd [[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-- Перед сохранением вырезаем пробелы на концах (только в .py файлах)
cmd [[ autocmd BufWritePre *.py normal m`:%s/\s\+$//e `` ]]
-- В .py файлах включаем умные отступы после ключевых слов
cmd [[ autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,match ]]
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]


-- LuaLine --------------------------------------------------------------
require('lualine').setup {
  options = {
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
}

-- TabLine ------------------

require'tabline'.setup {
-- Defaults configuration options
enable = true,
options = {

max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
show_devicons = true, -- this shows devicons in buffer section
show_bufnr = false, -- this appends [bufnr] to buffer section,
show_filename_only = false, -- shows base filename only instead of relative path in filename
modified_icon = "+ ", -- change the default modified icon
modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
  }
}
vim.cmd [[
  set guioptions-=e " Use showtabline in gui vim
  set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]


-- Sonokai --------------------------------------------------------------

g.sonokai_style = 'andromeda'
g.sonokai_enable_italic = 1                                                 
g.sonokai_disable_italic_comment = 1                                        
g.sonokai_transparent_background = 1
cmd 'colorscheme sonokai'           -- Должна быть последней!


-- NerdTree -------------------------------------------------------------

cmd [[
autocmd StdinReadPre * let s:std_in=1 
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
]]     


-- ALE ------------------------------------------------------------------

g.ale_sign_error = '✕'
g.ale_sign_warning = '⚠'


-- TreeSitter -----------------------------------------------------------

wo.foldmethod = 'expr'
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


