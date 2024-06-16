local lspkind = require 'lspkind'
lspkind.init {
  symbol_map = {
    TypeParameter = '',
  },
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  experimental = {
    ghost_text = true,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp', priority = 10 },
    { name = 'luasnip', priority = 9 },
    { name = 'calc' },
    { name = 'path' },
    { name = 'Codeium' },
    {
      name = 'buffer',
      priority = -2, -- Force buffer suggestions to the bottom
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    {
      name = 'lazydev',
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
  },
  window = {
    completion = cmp.config.window.bordered {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered {
      winhighlight = '',
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format {
        mode = 'symbol_text',
        maxwidth = 50,
        menu = { omni = 'omni' },
      }(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. (strings[1] or '') .. ' '

      -- Kind icons
      --vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      local menu_icon = {
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        calc = ' 󰃬 ',
      }
      if entry.source.name == 'calc' then
        -- Get the custom icon for 'calc' source
        -- Replace the kind glyph with the custom icon
        vim_item.kind = menu_icon.calc
        vim_item.menu = 'Calculator'
        kind.menu = 'Calculator'
      end
      kind.menu = '    (' .. (strings[2] or '') .. ') '
      return kind
    end,
  },

  view = {
    native_menu = false,
    entries = 'custom',
    window = {
      completion = {
        border = 'rounded',
        winhighlight = 'FloatBorder',
      },
    },
  },
}
