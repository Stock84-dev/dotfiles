-- INSTALL undo tree
-- Install packer
vim.cmd [[set termguicolors]]
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end
-- hello
vim.g.crunch_result_type_append = 0
vim.cmd [[
  let g:crunch_result_type_append = 0
]]

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- use { 'neoclide/coc.nvim', { branch = 'release' } }
  -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  -- use { 'ms-jpq/coq_nvim', branch = 'coq' }
  -- use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  -- use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  use 'arecarn/vim-crunch'
  -- use 'vim-scripts/diffchar.vim'

  -- Formatting
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')
  use 'Stock84-dev/auto-save.nvim' -- fork of 'AnonymusRaccoon/auto-save.nvim' -- fork of 'Pocco81/auto-save.nvim'
  -- Rust specific:
  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use 'simrat39/rust-tools.nvim'
  use { 'alopatindev/cargo-limit', run = 'cargo install cargo-limit nvim-send' }

  -- Debugging
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  -- Highlight color codes
  use "norcalli/nvim-colorizer.lua"
  use { "rebelot/kanagawa.nvim", commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92" }
  use 'xiyaowong/virtcolumn.nvim'
  -- Better <C-a>
  use 'monaqa/dial.nvim'

  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  use 'TC72/telescope-tele-tabby.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- rust-tools overrides lsp dependencies
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    'j-hui/fidget.nvim',

    -- Additional lua configuration, makes nvim stuff amazing
    'folke/neodev.nvim',
  }

  -- use { -- Autocompletion
  --   'hrsh7th/nvim-cmp',
  --   requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'windwp/nvim-autopairs' },
  -- }
  use 'L3MON4D3/LuaSnip'
  use 'windwp/nvim-autopairs'
  --
  --
  --
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-cmdline",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  --
  -- use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'github/copilot.vim'

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    commit = '31f608e',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use 'nvim-treesitter/playground'
  -- use {
  --   'm-demare/hlargs.nvim',
  --   requires = { 'nvim-treesitter/nvim-treesitter' }
  -- }
  use 'nvim-treesitter/nvim-treesitter-context'
  -- use 'p00f/nvim-ts-rainbow'

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'nvim-lualine/lualine.nvim'           -- Fancier statusline
  use { 'lukas-reineke/indent-blankline.nvim', commit = '9637670' } -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim'               -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth'                    -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use 'cljoly/telescope-repo.nvim'
  use "benfowler/telescope-luasnip.nvim"
  use 'nvim-telescope/telescope-ui-select.nvim'

  use { "danielfalk/smart-open.nvim", requires = { "kkharji/sqlite.lua" } }
  --use { 'rmagatti/session-lens', requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' } }

  -- use 'nvim-tree/nvim-web-devicons'
  use 'luochen1990/rainbow'
  use 'RRethy/vim-illuminate'

  -- Navigation
  -- For <C-S-o> to jump back a file from jump list
  use { 'inkarkat/vim-EnhancedJumps', requires = { 'inkarkat/vim-ingo-library' } }
  use 'ggandor/lightspeed.nvim'
  -- for da, delete around comma
  use 'wellle/targets.vim'
  -- makes word motions work on different cases like CamelCase
  use 'chaoren/vim-wordmotion'
  use 'rhysd/clever-f.vim'
  use { 'kevinhwang91/rnvimr', commit = "5f0483d"}
  use 'crispgm/nvim-tabline'

  use 'wakatime/vim-wakatime'
  --use 'rmagatti/auto-session'
  use 'Shatur/neovim-session-manager'

  use 'mbbill/undotree'

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

--vim.cmd('source <sfile>:h/after/main.vim')
-- TODO: this dosn't open correct file when cwd is different dir
--vim.cmd('exe "source " . fnamemodify("$MYVIMRC", ":h") . "/after/main.vim"')
--vim.cmd('exe "source after/main.vim"')

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end


-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
local sfile = vim.fn.expand '$MYVIMRC'

-- [[ Setting options ]]
-- See `:help vim.o`


-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'r'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.cmd [[

augroup Illuminate_augroup
    autocmd VimEnter * hi IlluminatedWordWrite gui=NONE guibg=#2c120f
    autocmd VimEnter * hi IlluminatedWordText gui=NONE guibg=#002224
    autocmd VimEnter * hi IlluminatedWordRead gui=NONE guibg=#152900
    autocmd VimEnter * hi IlluminatedCurWord gui=NONE guibg=#002628
augroup END
]]
require('illuminate').configure()

-- Set colorscheme
vim.o.termguicolors = true
require('kanagawa').setup({
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = false, bold = false },
  statementStyle = { bold = false },
  typeStyle = { bold = false },
  variablebuiltinStyle = { italic = false, bold = false },
  specialReturn = true,    -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = false,     -- do not set background color
  dimInactive = false,     -- dim inactive window `:h hl-NormalNC`
  globalStatus = false,    -- adjust window separators highlight for laststatus=3
  terminalColors = true,   -- define vim.g.terminal_color_{0,17}
  colors = {
    -- Bg Shades
    sumiInk0  = "#073642",
    sumiInk1b = "#181820",
    sumiInk1c = "#1a1a22",
    --sumiInk1      = "#1F1F28",
    sumiInk1  = "#002B36",
    sumiInk2  = "#2A2A37",
    sumiInk3  = "#073642",
    --sumiInk4      = "#54546D",
    sumiInk4  = "#586E75",



    -- Popup and Floats
    waveBlue1     = "#073642",
    waveBlue2     = "#2D4F67",

    -- Diff and Git
    winterGreen   = "#2B3328",
    winterYellow  = "#49443C",
    winterRed     = "#43242B",
    winterBlue    = "#252535",
    autumnGreen   = "#76946A",

    autumnRed     = "#C34043",
    autumnYellow  = "#DCA561",

    -- Diag
    samuraiRed    = "#E82424",
    roninYellow   = "#FF9E3B",
    waveAqua1     = "#6A9589",
    dragonBlue    = "#658594",

    -- Fg and Comments
    oldWhite      = "#C8C093",
    fujiWhite     = "#93A1A1",
    --fujiWhite     = "#DCD7BA",
    fujiGray      = "#727169",
    springViolet1 = "#938AA9",

    oniViolet     = "#859900",
    --oniViolet     = "#957FB8",
    crystalBlue   = "#D33682",
    --crystalBlue   = "#7E9CD8",

    springViolet2 = "#9CABCA",
    springBlue    = "#7FB4CA",
    lightBlue     = "#A3D4D5", -- unused yet
    waveAqua2     = "#268BD2", -- improve lightness: desaturated greenish Aqua
    --waveAqua2     = "#7AA89F", -- improve lightness: desaturated greenish Aqua

    -- waveAqua2  = "#68AD99",
    -- waveAqua4  = "#7AA880",
    -- waveAqua5  = "#6CAF95",
    -- waveAqua3  = "#68AD99",

    springGreen   = "#98BB6C",
    boatYellow1   = "#938056",
    boatYellow2   = "#C0A36E",
    carpYellow    = "#6C71C4",
    --carpYellow    = "#E6C384",

    sakuraPink    = "#D27E99",
    waveRed       = "#E46876",
    peachRed      = "#FF5D62",
    surimiOrange  = "#CB4B16",
    --surimiOrange  = "#FFA066",
    katanaGray    = "#717C7C",
  },
  overrides = {
    Boolean = { bold = false },
  },
  theme = "default" -- Load "default" theme or the experimental "light" theme
})
--require('hlargs').setup {
--  color = "#B58900",
--  --highlight = {},
--  --excluded_filetypes = {},
--  --disable = function(lang, bufnr) -- If changed, `excluded_filetypes` will be ignored
--  --  return vim.tbl_contains(opts.excluded_filetypes, lang)
--  --end,
--  --paint_arg_declarations = true,
--  --paint_arg_usages = true,
--  --paint_catch_blocks = {
--  --  declarations = false,
--  --  usages = false
--  --},
--  --extras = {
--  --  named_parameters = false,
--  --},
--  --hl_priority = 10000,
--  --excluded_argnames = {
--  --  declarations = {},
--  --  usages = {
--  --    python = { 'self', 'cls' },
--  --    lua = { 'self' }
--  --  }
--  --},
--  --performance = {
--  --  parse_delay = 1,
--  --  slow_parse_delay = 50,
--  --  max_iterations = 400,
--  --  max_concurrent_partial_parses = 30,
--  --  debounce = {
--  --    partial_parse = 3,
--  --    partial_insert_mode = 100,
--  --    total_parse = 700,
--  --    slow_parse = 5000
--  --  }
--  --}
--}

vim.cmd [[colorscheme kanagawa]]
vim.api.nvim_set_hl(0, '@lsp.type.variable.rust', {})
vim.api.nvim_set_hl(0, '@lsp.mod.constant.rust', { fg = "#CB4B16" })
vim.api.nvim_set_hl(0, '@lsp.type.selfKeyword.rust', {})
vim.api.nvim_set_hl(0, '@lsp.type.parameter.rust', { fg = "#B58900" })
vim.api.nvim_set_hl(0, '@parameter', { fg = "#93A1A1" })
vim.api.nvim_set_hl(0, '@namespace', { fg = "#93A1A1" })
vim.api.nvim_set_hl(0, '@variable', { fg = "#93A1A1" })
-- vim.api.nvim_set_hl(0, '@lsp.type.variable.rust', { fg = "#93A1A1" })
vim.api.nvim_set_hl(0, '@lsp.type.namespace.rust', { fg = "#93A1A1" })
vim.api.nvim_set_hl(0, '@lsp.type.decorator.rust', { fg = "#CB4B16" })
vim.api.nvim_set_hl(0, '@lsp.typemod.namespace.library.rust', { fg = "#93A1A1" })
vim.api.nvim_set_hl(0, '@lsp.typemod.keyword.crateRoot.rust', { fg = "#859900" })
vim.api.nvim_set_hl(0, '@type.qualifier', { fg = "#859900" })
--vim.api.nvim_set_hl(0, '@variable', { fg = "#FF0000" })
--vim.api.nvim_set_hl(0, '@type', { fg = "#FF0000" })
-- vim.api.nvim_set_hl(0, '@function.call', { fg = "#FF0000" })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = "#CB4B16" })
vim.api.nvim_set_hl(0, '@number', { fg = "#CB4B16" })
vim.api.nvim_set_hl(0, '@float', { fg = "#CB4B16" })
vim.api.nvim_set_hl(0, '@string', { fg = "#2AA198" })
vim.api.nvim_set_hl(0, '@keyword.return', { fg = "#859900" })
vim.api.nvim_set_hl(0, '@punctuation.special', { fg = "#B58900" })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = "#B58900" })
--vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = "#586E75" })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = "" })
vim.api.nvim_set_hl(0, '@storageclass', { fg = "#859900" })
vim.api.nvim_set_hl(0, '@storageclass.lifetime', { fg = "#2AA198" })
vim.api.nvim_set_hl(0, '@include', { fg = "#859900" })
-- unlik to enable rainbow colors
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })
vim.api.nvim_set_hl(0, "@operator", { link = "" })
vim.cmd [[syn match MyStockOperator '+\|-\|_\|=\|\*\|&\|\^\|%\|\$\|#\|@\|!\|\~\|\,\|;\|:\|.']]
vim.cmd [[hi MyStockOperator ctermfg=lightyellow guifg=#B58900]]

vim.cmd [[set cursorline]]
vim.cmd [[hi VirtColumn ctermfg=lightyellow guifg=#073642]]
vim.cmd [[set colorcolumn=100]]
vim.cmd [[set scrolloff=999]]
-- Set highlight on search
vim.o.hlsearch = false


--local everblush = require('everblush')
--everblush.setup({ nvim_tree = { contrast = true } })

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('cmp_config')
require('telescope_config')
require("colorizer").setup()
require('dial_config')
require('snippets')
local keymap = require('keymap')
--require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
--require'pounce'.setup{
--  accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
--  accept_best_key = "<enter>",
--  multi_window = true,
--  debug = false,
--}

require('tabline').setup({
  show_index = true,        -- show tab index
  show_modify = true,       -- show buffer modification indicator
  modify_indicator = '[+]', -- modify indicator
  no_name = '[No name]',    -- no name buffer name
})

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  --char = '┊',
  --show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require("nvim-autopairs").setup {
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'vim' },
  additional_vim_regex_highlighting = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        -- ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        -- ['<leader>A'] = '@parameter.inner',
      },
    },
  },
  --rainbow = {
  --  enable = true,
  --  -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --  max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --  --colors = {
  --  --  "B58900",
  --  --  "859900",
  --  --  "93A1A1",
  --  --  "6C71C4",
  --  --  "D33682",
  --  --  "D33682",
  --  --  "D33682",
  --  --}, -- table of hex strings
  --  -- termcolors = {} -- table of colour name strings
  --  colors = {
  --    "#b58900",
  --    "#859900",
  --    "#93a1a1",
  --    "#6c71c4",
  --    "#d33682",
  --    "#cb4b16",
  --    "#2aa198",
  --  },
  --  termcolors = {
  --    --"Red",
  --    --"Green",
  --    --"Yellow",
  --    --"Blue",
  --    --"Magenta",
  --    --"Cyan",
  --    --"White",
  --  },
  --}
}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  rust_analyzer = {},
  -- tsserver = {},
  lua_ls = {},

  -- sumneko_lua = {
  --   Lua = {
  --     workspace = { checkThirdParty = false },
  --     telemetry = { enable = false },
  --   },
  -- },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      -- on_attach = Lsp_on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- must be called after expanding $MYVIMRC
vim.cmd('exe "source " . fnamemodify("' .. sfile .. '", ":p:h") . "/after/main.vim"')
--vim.cmd [[autocmd BufNewFile,BufRead * syn match MyStockOperator '+\|-\|_\|=\|\*\|&\|\^\|%\|\$\|#\|@\|!\|\~\|\,\|;\|:\|.']]
--vim.cmd [[autocmd BufNewFile,BufRead * hi MyStockOperator ctermfg=lightyellow guifg=#B58900]]
--vim.cmd [[hi MyStockOperator ctermfg=lightyellow guifg=#B58900]]
--vim.cmd [[autocmd BufReadPre,BufRead,BufReadPost * syn match MyStockOperator '+\|-\|_\|=\|\*\|&\|\^\|%\|\$\|#\|@\|!\|\~\|\,\|;\|:\|.']]
--vim.cmd [[autocmd BufReadPre,BufRead,BufReadPost * echo "hi"]]
vim.cmd [[hi MyStockOperator ctermfg=lightyellow guifg=#B58900]]
-- This must match some file but not all, it messes up Ranger
vim.cmd [[autocmd VimEnter,BufNew rust,lua syn match MyStockOperator '+\|-\|_\|=\|\*\|&\|\^\|%\|\$\|#\|@\|!\|\~\|\,\|;\|:\|.']]
vim.cmd [[
autocmd VimEnter,BufNew * RainbowToggleOn
highlight IndentBlanklineChar guifg=#073642 gui=nocombine
hi TelescopeResultsStruct guifg=#268bd2
autocmd VimEnter * ":RnvimrStartBackground<CR>"
]]


require 'lightspeed'.setup {
  ignore_case = true,
  exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
  --- s/x ---
  jump_to_unique_chars = { safety_timeout = 400 },
  match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = false,
  -- Display characters in a custom way in the highlighted matches.
  substitute_chars = { ['\r'] = '¬', },
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  -- safe_labels = { . . . },
  -- labels = { . . . },
  -- These keys are captured directly by the plugin at runtime.
  special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
  },
  --- f/t ---
  limit_ft_matches = 4,
  repeat_ft_with_target_char = false,
}

local rt = require("rust-tools")

local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools.executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "FoldColumn",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = false,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
    on_attach = keymap.rust_keymaps,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          -- lint with --all-features
          features = "all",
          --["buildScripts.overrideCommand"] = {"cargo", "clippy", "--workspace", "--message-format=json", "--all-targets"},
        },
        assist = {
          -- when filling struct fields use default constructor
          expressionFillDefault = "default",
        },
        check = {
          command = "clippy",
          extraArgs = { "--all", "--", "-W", "clippy::all" },
        },
        -- checkOnSave = {
        --   overrideCommand = { "cargo", "clippy", "--fix", "--workspace", "--message-format=json", "--all-targets",
        --     "--allow-dirty" },
        -- },
        completion = {
          ["callable.snippets"] = "",
          ["privateEditable.enable"] = true,
        },
        diagnostics = {
          ["experimental.enable"] = true,
        },
        imports = {
          ["granularity.enforce"] = true,
        },
        inlayHints = {
          ["bindingModeHints.enable"] = true,
          ["closingBraceHints.minLines"] = 0,
          ["closureReturnTypeHints.enable"] = "always",
          ["lifetimeElisionHints.enable"] = "always",
          ["lifetimeElisionHints.useParameterNames"] = true,
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
        ["typing.autoClosingAngleBrackets.enable"] = true,
      }
    }
  }, -- rust-analyzer options
  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
}

rt.setup(opts)

-- Enable inlay hints auto update and set them for all the buffers
require('rust-tools').inlay_hints.enable()
local text_changed_time = 0
local auto_save_delay_s = 5
local text_changed_by_formatter_time = 0
local function set_changed_time()
  local now = os.time()
  if now - text_changed_by_formatter_time < 2 then
    text_changed_time = os.time() + auto_save_delay_s + 1
  else
    text_changed_time = os.time()
  end
  -- io.popen("notify-send " .. vim.fn.strftime("%H:%M:%S"))
end

local group = vim.api.nvim_create_augroup("AutoSaveTextChanged", { clear = true })
vim.api.nvim_create_autocmd("TextChangedI", { callback = set_changed_time, group = group })
vim.api.nvim_create_autocmd("TextChanged", { callback = set_changed_time, group = group })
vim.api.nvim_create_autocmd("InsertLeave", { callback = set_changed_time, group = group })
vim.api.nvim_create_autocmd("InsertLeave", { callback = set_changed_time, group = group })
vim.api.nvim_create_autocmd("CursorMoved", { callback = set_changed_time, group = group })

require('auto-save').setup({
  enabled = true,        -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
  execution_message = {
    message = function() -- message to print on save
      --return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
      return ("")
    end,
    dim = 0.18,                                      -- dim the color of `message`
    cleaning_interval = 1250,                        -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
  trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
  --trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
  -- function that determines whether to save the current buffer or not
  -- return true: if buffer is ok to be saved
  -- return false: if it's not ok to be saved
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")
    local elapsed_s = os.time() - text_changed_time

    -- io.popen("notify-send checking " .. elapsed_s)
    -- if bufer is modified and modifiable and not in blacklist
    local in_normal_mode = vim.api.nvim_get_mode().mode == "n"
    local debounced = elapsed_s > auto_save_delay_s - 2
    local modified = fn.getbufvar(buf, "&mod") == 1
    local modifiable = fn.getbufvar(buf, "&modifiable") == 1
    local not_blacklisted = utils.not_in(fn.getbufvar(buf, "&filetype"), {})
    if in_normal_mode and debounced and modifiable and not_blacklisted then
      return true                            -- met condition(s), can save
    end
    return false                             -- can't save
  end,
  write_all_buffers = false,                 -- write all buffers when the current one meets `condition`
  debounce_delay = auto_save_delay_s * 1000, -- saves the file at most every `debounce_delay` milliseconds
  callbacks = {                              -- functions to be executed at different intervals
    enabling = nil,                          -- ran when enabling auto-save
    disabling = nil,                         -- ran when disabling auto-save
    before_asserting_save = nil,             -- ran before checking `condition`
    --before_saving = nil,
    before_saving = function(buf)
      text_changed_by_formatter_time = os.time()
      keymap.format()
    end,               -- ran before doing the actual save
    after_saving = nil -- ran after doing the actual save
  }
})

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        -- vim.lsp.buf.formatting_sync(nil, 1000)
        vim.lsp.buf.format()
        -- vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format()
          -- vim.lsp.buf.formatting_sync(nil, 1000)
          -- vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    -- if client.supports_method("textDocument/rangeFormatting") then
    --   vim.keymap.set("x", "<Leader>f", function()
    --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    --   end, { buffer = bufnr, desc = "[lsp] format" })
    -- end
  end,
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "toml",
    "rust",
    "lua",
  },
})

local Path = require('plenary.path')
require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),               -- The directory where the session files will be saved.
  path_replacer = '__',                                                      -- The character to which the path separator will be replaced for session files.
  colon_replacer = '++',                                                     -- The character to which the colon symbol will be replaced for session files.
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_last_session = true,                                              -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true,                                         -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_dirs = {},                                                 -- A list of directories where the session will not be autosaved.
  autosave_ignore_filetypes = {                                              -- All buffers of these file types will be closed before the session is saved.
    'gitcommit',
  },
  autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})

vim.cmd [[
  imap <silent><script><expr> <C-Enter> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]]

--
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
-- function _G.check_back_space()
--   local col = vim.fn.col('.') - 1
--   return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end

-- -- Use Tab for trigger completion with characters ahead and navigate
-- -- NOTE: There's always a completion item selected by default, you may want to enable
-- -- no select by setting `"suggest.noselect": true` in your configuration file
-- -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- -- other plugins before putting this into your config
-- local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
-- keyset("i", "<C-j>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- keyset("i", "<C-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
--
-- -- Make <CR> to accept selected completion item or notify coc.nvim to format
-- -- <C-g>u breaks current undo, please make your own choice
-- keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
--
-- -- Use <c-j> to trigger snippets
-- keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- -- Use <c-space> to trigger completion
-- keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
--
-- -- Use `[g` and `]g` to navigate diagnostics
-- -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
-- keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
-- keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
--
-- -- GoTo code navigation
-- keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
-- keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
-- keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
-- keyset("n", "gr", "<Plug>(coc-references)", { silent = true })
--
--
-- -- Use K to show documentation in preview window
-- function _G.show_docs()
--   local cw = vim.fn.expand('<cword>')
--   if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
--     vim.api.nvim_command('h ' .. cw)
--   elseif vim.api.nvim_eval('coc#rpc#ready()') then
--     vim.fn.CocActionAsync('doHover')
--   else
--     vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
--   end
-- end
--
-- keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })
--
--
-- -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
-- vim.api.nvim_create_augroup("CocGroup", {})
-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = "CocGroup",
--   command = "silent call CocActionAsync('highlight')",
--   desc = "Highlight symbol under cursor on CursorHold"
-- })
--
--
-- -- Symbol renaming
-- keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
--
--
-- -- Formatting selected code
-- keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
-- keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
--
--
-- -- Setup formatexpr specified filetype(s)
-- vim.api.nvim_create_autocmd("FileType", {
--   group = "CocGroup",
--   pattern = "typescript,json",
--   command = "setl formatexpr=CocAction('formatSelected')",
--   desc = "Setup formatexpr specified filetype(s)."
-- })
--
-- -- Update signature help on jump placeholder
-- vim.api.nvim_create_autocmd("User", {
--   group = "CocGroup",
--   pattern = "CocJumpPlaceholder",
--   command = "call CocActionAsync('showSignatureHelp')",
--   desc = "Update signature help on jump placeholder"
-- })
--
-- -- Apply codeAction to the selected region
-- -- Example: `<leader>aap` for current paragraph
-- local opts = { silent = true, nowait = true }
-- keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
-- keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
--
-- -- Remap keys for apply code actions at the cursor position.
-- keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- -- Remap keys for apply code actions affect whole buffer.
-- keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- -- Remap keys for applying codeActions to the current buffer
-- keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
-- -- Apply the most preferred quickfix action on the current line.
-- keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
--
-- -- Remap keys for apply refactor code actions.
-- keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
-- keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
-- keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
--
-- -- Run the Code Lens actions on the current line
-- keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)
--
--
-- -- Map function and class text objects
-- -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
-- keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
-- keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
-- keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
-- keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
-- keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
-- keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
-- keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
-- keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)
--
--
-- -- Remap <C-f> and <C-b> to scroll float windows/popups
-- ---@diagnostic disable-next-line: redefined-local
-- local opts = { silent = true, nowait = true, expr = true }
-- keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
-- keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
-- keyset("i", "<C-f>",
--   'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
-- keyset("i", "<C-b>",
--   'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
-- keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
-- keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
--
--
-- -- Use CTRL-S for selections ranges
-- -- Requires 'textDocument/selectionRange' support of language server
-- keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
-- keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
--
--
-- -- Add `:Format` command to format current buffer
-- vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
--
-- -- " Add `:Fold` command to fold current buffer
-- vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
--
-- -- Add `:OR` command for organize imports of the current buffer
-- vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
--
-- -- Add (Neo)Vim's native statusline support
-- -- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- -- provide custom statusline: lightline.vim, vim-airline
-- vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
--
-- -- Mappings for CoCList
-- -- code actions and coc stuff
-- ---@diagnostic disable-next-line: redefined-local
-- -- local opts = { silent = true, nowait = true }
-- -- -- Show all diagnostics
-- -- keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- -- -- Manage extensions
-- -- keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- -- -- Show commands
-- -- keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- -- -- Find symbol of current document
-- -- keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- -- -- Search workspace symbols
-- -- keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- -- -- Do default action for next item
-- -- keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- -- -- Do default action for previous item
-- -- keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- -- -- Resume latest coc list
-- -- keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
--

-- vim.g.coq_settings = {
--   auto_start = 'shut-up',
--   keymap = {
--     -- recommended = false,
--     pre_select = true,
--     jump_to_mark = "<c-,>"
--   },
--   -- limits = {
--   --   completion_auto_timeout = 0.988
--   -- },
--   -- match = {
--   --   max_results = 9000,
--   -- },
--   clients = {
--     paths = {
--       path_seps = {
--         "/"
--       }
--     },
--     buffers = {
--       match_syms = true
--     }
--   },
--   display = {
--     ghost_text = {
--       enabled = true
--     }
--   }
-- }
-- require("coq")

vim.cmd [[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" Use the undo file
set undofile

" When loading a file, store the curent undo sequence
augroup undo
    autocmd!
    autocmd BufReadPost,BufCreate,BufNewFile * let b:undo_saved = undotree()['seq_cur'] | let b:undo_warned = 0
augroup end

" Remap the keys
nnoremap u :call Undo()<Cr>u
nnoremap <C-r> <C-r>:call Redo()<Cr>


fun! Undo()
    " Don't do anything if we can't modify the buffer or there's no filename
    if !&l:modifiable || expand('%') == '' | return | endif

    " Warn if the current undo sequence is lower (older) than whatever it was
    " when opening the file
    if !b:undo_warned && undotree()['seq_cur'] <= b:undo_saved
        let b:undo_warned = 1
        echohl ErrorMsg | echo 'WARNING! Using undofile!' | echohl None
        sleep 1
    endif
endfun

fun! Redo()
    " Don't do anything if we can't modify the buffer or there's no filename
    if !&l:modifiable || expand('%') == '' | return | endif

    " Reset the warning flag
    if &l:modifiable && b:undo_warned && undotree()['seq_cur'] >= b:undo_saved
        let b:undo_warned = 0
    endif
endfun
]]
-- Avoid showing extra messages when using completion
-- vim.opt.shortmess = vim.opt.shortmess + "c"
-- function HandleTabInInsert()
--     -- Check if we are in Visual mode
--     vim.fn.system("notify-send pre")
--     if vim.fn.visualmode() == 'V' then
--         vim.fn.system("notify-send v")
--         -- Exit Visual mode
--         -- vim.cmd([[normal! <Esc>]])
--     end
--
--     -- Emit "ci(<C-Space>"
--     -- vim.api.nvim_feedkeys("ci(<C-Space>", "i", true)
-- end
--
-- -- Set up the autocmd to trigger the function on <Tab> press in Insert mode
-- vim.api.nvim_exec([[
--     autocmd! FileType * autocmd InsertChar <Tab> call v:lua.HandleTabInInsert()
-- ]], false)





require('crates').setup {
  src = {
    -- coq = {
    --   enabled = true,
    --   name = "crates.nvim",
    -- },
  },
  null_ls = {
    enabled = true,
    name = "crates.nvim",
  },
}
