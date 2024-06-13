local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}
local f = cmp_autopairs.on_confirm_done();

-- show signature help
function on_confirm_done(evt)
  f(evt)
  print(vim.fn.visualmode())
  if vim.fn.visualmode() == 'v' then
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local prev_char = vim.api.nvim_get_current_line():sub(col,col)
    -- vim.fn.system("notify-send '" .. char .. "'")
    if prev_char == '(' then
      -- vim.fn.system("notify-send v")
      vim.defer_fn(function() 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>da(", true, false, true), "tx", false)
      end, 2)
      vim.defer_fn(function() 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a", true, false, true), "tx!", false)
      end, 4)
      vim.defer_fn(function() 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("(", true, false, true), "i", false)
      end, 8)
    end
  end
end

-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
cmp.event:on(
  'confirm_done',
  on_confirm_done
)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<Tab>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
	if not entry then
	  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	else
	  cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert })
	end
      else
        fallback()
      end
    end, {"i","s","c",}),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sorting = {
    comparators = {
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      cmp.config.compare.offset,
      cmp.config.compare.order,
      --     cmp.config.compare.score,
      --     cmp.config.compare.offset,
      --     cmp.config.compare.exact,
      --     cmp.config.compare.kind,
      --     -- cmp.config.compare.sort_text,
      --     cmp.config.compare.length,
      --     cmp.config.compare.order,
    }
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(_, vim_item)
      vim_item.kind = cmp_kinds[vim_item.kind] or ""
      return vim_item
    end,
  },
  -- formatting = {
  --   format = function(entry, vim_item)
  --     vim_item.menu = entry:get_completion_item().detail
  --     return vim_item
  --   end
  -- },
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
    completeopt = "menuone,noinsert,noselect"
  },
  sources = {
    { name = "crates", priority = 10 },
    { name = 'nvim_lsp', priority = 8 },
    { name = 'nvim_lsp_signature_help' },
    -- { name = 'luasnip' },
    { name = "path" },
    { name = "buffer" }
  },
}
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- vim.api.nvim_create_autocmd("BufRead", {
--     group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
--     pattern = "Cargo.toml",
--     callback = function()
--         cmp.setup.buffer({ sources = { { name = "crates" }, { name = "path" } } })
--     end,
-- })

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['rust-analyzer'].setup {
--   capabilities = capabilities
-- }
-- function emitCtrlSpace()
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-Space>", true, true, true), "i", true)
--     -- vim.fn.system("notify-send hi")
-- end
-- vim.api.nvim_exec([[
--     augroup TextChangeMonitor
--         autocmd!
--         autocmd CursorMovedI *.rs lua emitCtrlSpace()
--     augroup END
-- ]], false)
