local api = vim.api
local cmd = vim.cmd                 -- execute Vim commands
local exec = api.nvim_exec          -- execute Vimscript
local g = vim.g                     -- global variables
local opt = vim.opt                 -- global/buffer/windows-scoped options

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
opt.so=999                          -- Курсор всегда в центре экрана
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


-- Sonokai --------------------------------------------------------------

g.airline_theme = 'sonokai'
g.sonokai_style = 'andromeda'
g.sonokai_enable_italic = 1                                                 
g.sonokai_disable_italic_comment = 1                                        
g.sonokai_transparent_background = 1
cmd 'colorscheme sonokai'           -- Должна быть последней!


-- Откроет nvim с боковой панелью nerdtree текущего каталога ------------
cmd [[
autocmd StdinReadPre * let s:std_in=1 
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
]]     


-- TreeSitter -----------------------------------------------------------

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
