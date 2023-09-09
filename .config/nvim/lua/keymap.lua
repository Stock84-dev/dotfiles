local M = {}
local rt = require("rust-tools")
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<C-l>",
  ":RnvimrToggle<CR>",
  { noremap = true }
)
-- vim.api.nvim_set_keymap(
--   "n",
--   "<C-l>",
--   ":Telescope file_browser path=%:p:h<CR><Esc>",
--   { noremap = true }
-- )

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.api.nvim_set_keymap("n", "<C-h>",
  "<Cmd>lua require('telescope').extensions.smart_open.smart_open({ previewer = false })<CR>",
  { noremap = true, silent = true })
--vim.keymap.set('n', '<C-h>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>ch', ':Cheatsheet<CR>', { desc = '[C]heat[S]heet' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>st', require('telescope').extensions.tele_tabby.list, { desc = '[S]earch [T]abs' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>km', require('telescope.builtin').keymaps, { desc = '[K]ey[m]aps' })
vim.keymap.set('n', '<leader>cm', require('telescope.builtin').commands, { desc = '[C]o[m]mands' })
vim.keymap.set('n', '<leader>lg', require('telescope.builtin').grep_string, { desc = '[L]ive [G]rep in workspace' })
vim.keymap.set('n', '<leader>os', ':SessionManager load_session<CR>', { desc = '[O]pen [S]ession' })
vim.keymap.set('n', '<leader>op', ':Telescope repo list<CR>', { desc = '[O]pen [P]roject' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<C-m>', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ 'vim', 'help' }, filetype) then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.tbl_contains({ 'man' }, filetype) then
    vim.cmd('Man ' .. vim.fn.expand('<cword>'))
  elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
    require('crates').show_popup()
  else
    require 'rust-tools'.hover_actions.hover_actions()
  end
end

vim.keymap.set('n', '<C-q>', show_documentation, { noremap = true, silent = true })

local showSymbolFinder = function()
  -- lowercase for simplicity :)
  local lsp_symbols = vim.tbl_map(string.lower, vim.lsp.protocol.SymbolKind)
  -- define a filter function to excl. undesired symbols
  local symbols = vim.tbl_filter(function(symbol) return symbol ~= "field" and symbol ~= "enummember" and symbol ~= "object" end, lsp_symbols)
  require('telescope.builtin').lsp_document_symbols { symbols = symbols, show_line = true }
end


-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
function Lsp_on_attach(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>a', rt.code_action_group.code_action_group, 'Code [A]ction')
  -- nmap('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')
  --nmap('<C-q>', vim.lsp.buf.hover, 'Show documentation')
  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<C-e>', showSymbolFinder,
    -- nmap('<C-e>', function() require('telescope.builtin').lsp_document_symbols { show_line = true } end,
    '[D]ocument [S]ymbols')
  nmap('<C-p>', function() require('telescope.builtin').lsp_dynamic_workspace_symbols { show_line = true } end,
    'Workspace Symbols')
  nmap('<leader>di', function() require('telescope.builtin').diagnostics { bufnr = 0 } end, '[D][i]agnostics')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Navigation
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Use set scrolloff=999
-- vim.keymap.set('n', "<C-u>", "<C-u>zz", { noremap = true })
-- vim.keymap.set('n', "<C-d>", "<C-d>zz", { noremap = true })
-- vim.keymap.set('n', "n", "nzzzv", { noremap = true })
-- vim.keymap.set('n', "N", "NzzzV", { noremap = true })
-- vim.keymap.set('n', "<C-o>", "<C-o>zz", { noremap = true })
-- vim.keymap.set('n', "<C-i>", "<C-i>zz", { noremap = true })
-- local last_text_object = "w"
-- -- Go to the begining of the next text object. Use ";;" to go to the next even while inside it.
-- local function goto_next_text_object(reverse)
--   local move = function(text_object)
--     vim.api.nvim_feedkeys("v", "n", false)
--     vim.api.nvim_feedkeys("a", "v", false)
--     vim.api.nvim_feedkeys(text_object, "v", false)
--     if reverse ~= true then
--       vim.api.nvim_feedkeys("o", "v", false)
--     end
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "v", false)
--   end
--   local char = vim.fn.getcharstr()
--   if char == ";" then
--     vim.api.nvim_feedkeys("v", "n", false)
--     vim.api.nvim_feedkeys("a", "v", false)
--     vim.api.nvim_feedkeys(last_text_object, "v", false)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "v", false)
--     local y, x = unpack(vim.api.nvim_win_get_cursor(0))
--     local lines = vim.api.nvim_buf_get_lines(0, y, y + 1, false)
--     local width = string.len(lines[1])
--     print(width)
--     io.popen("echo '" .. lines[1] .. "' >> /tmp/lua")
--     -- + 2 for \n
--     if x + 2 >= width then
--       vim.api.nvim_win_set_cursor(0, {y + 1, 0})
--     else
--       vim.api.nvim_win_set_cursor(0, {y, x + 1})
--     end
--     --move(last_text_object)
--   else
--     last_text_object = char
--     move(last_text_object)
--   end
-- end
-- vim.keymap.set('n', ";", function() goto_next_text_object(false) end, { noremap = true })
-- vim.keymap.set('n', ",", function() goto_next_text_object(false) end, { noremap = true })

vim.keymap.set('n', "<C-S-o>", "<Plug>EnhancedJumpsRemoteOlderzz", { noremap = true })
vim.keymap.set('n', "<C-S-i>", "<Plug>EnhancedJumpsRemoteNewerzz", { noremap = true })

--local hop = require('hop')
--local directions = require('hop.hint').HintDirection
--vim.keymap.set('n', '<C-j>', function()
--  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
--end, {remap=true})
--vim.keymap.set('n', '<C-k>', function()
--  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
--end, {remap=true})


vim.keymap.set('n', "<C-j>", "<Plug>Lightspeed_s", { noremap = true })
vim.keymap.set('n', "<C-k>", "<Plug>Lightspeed_S", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })


local crates = require('crates')
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ct', crates.toggle, opts)
vim.keymap.set('n', '<leader>cr', crates.reload, opts)

vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)

vim.keymap.set('n', '<leader>cu', crates.update_crate, opts)
vim.keymap.set('v', '<leader>cu', crates.update_crates, opts)
vim.keymap.set('n', '<leader>ca', crates.update_all_crates, opts)
vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, opts)
vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, opts)
vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, opts)

vim.keymap.set('n', '<leader>cH', crates.open_homepage, opts)
vim.keymap.set('n', '<leader>cR', crates.open_repository, opts)
vim.keymap.set('n', '<leader>cD', crates.open_documentation, opts)
vim.keymap.set('n', '<leader>cC', crates.open_crates_io, opts)

local rt = require("rust-tools")
function M.rust_keymaps(_, bufnr)
  Lsp_on_attach(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'Rust: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('<S-j>', rt.join_lines.join_lines, 'Join lines')
  nmap('<C-s>', rt.parent_module.parent_module, 'Go to parent module')
  nmap('<A-d>', '<cmd>RustOpenExternalDocs<CR>', 'Open documentation in browser')

  -- Hover actions
  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  -- Code action groups
  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  vim.keymap.set('n', '<leader>rr', require('rust-tools').runnables.runnables, { noremap = true })
  vim.keymap.set('n', '<leader>em', require('rust-tools').expand_macro.expand_macro, { noremap = true })

  vim.keymap.set('n', '<leader>kk',
    function()
      local up = true
      require 'rust-tools'.move_item.move_item(up)
    end
    , { noremap = true })


  vim.keymap.set('n', '<leader>jj',
    function()
      local down = false
      require 'rust-tools'.move_item.move_item(down)
    end
    , { noremap = true })
end

function M.format()
  -- io.popen("notify-send formatting")
  -- First use prettier to fix syntax mistakes
  -- vim.cmd [[Prettier]] -- Removes trailing dot when formatting Rust numbers
  -- Then format it with lsp
  --vim.lsp.buf.formatting_sync(nil, 1000)
  vim.defer_fn(function() vim.lsp.buf.formatting_sync(nil, 1000) end, 500)

  -- Formatting with lsp is still async, so we need to save again
  vim.defer_fn(function() vim.cmd [[wa]] end, 1500)
end

nmap("<leader>ff", M.format, '[F]ormat [F]ile')

-- Map to linewise comment
vim.cmd [[
vmap <C-/> gc
nmap <C-/> gcc
nmap <C-f> /^impl<CR>
nmap <C-b> ?^impl<CR>
]]

-- snippets
vim.cmd [[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <C-Enter> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-Enter>'

" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

return M
