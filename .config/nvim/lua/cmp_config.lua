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

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
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
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
  sources = {
    { name = 'nvim_lsp', priority = 8 },
    -- { name = 'nvim_lsp_signature_help' },
    -- { name = 'luasnip' },
    -- { name = "crates" },
    -- { name = "path" },
    -- { name = "buffer" }
  },
}

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['rust-analyzer'].setup {
--   capabilities = capabilities
-- }
