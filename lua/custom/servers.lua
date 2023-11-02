return {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  ltex = {
    ltex = {
      language = 'en-GB',
      disabledRules = { ['en-GB'] = { 'OXFORD_SPELLING_Z_NOT_S', 'ARROWS', 'NORTH_POLE' } },
    },
  },
  pyright = {},
  tailwindcss = {},
  zls = {},
  cssls = {},
  dockerls = {},
  html = {},
  vimls = {},
  marksman = {},
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
      shadow = true,
    },
    staticcheck = true,
  },
}
