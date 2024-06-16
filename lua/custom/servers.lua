return {
  -- lua_ls = {
  --   Lua = {
  --     workspace = { checkThirdParty = false },
  --     telemetry = { enable = false },
  --   },
  -- },
  pyright = {},
  -- pylyzer = {},
  -- ruff_lsp = {},
  tailwindcss = {},
  zls = {},
  cssls = {},
  dockerls = {},
  html = {},
  vimls = {},
  marksman = {},
  texlab = {},
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
      shadow = true,
    },
    staticcheck = true,
  },
}
