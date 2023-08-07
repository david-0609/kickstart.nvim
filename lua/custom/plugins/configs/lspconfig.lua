-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("custom.utils").on_attach
local capabilities = require("custom.utils").capabilities
local has_rust_tools, rust_tools = pcall(require, "rust-tools")

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "pyright", "marksman", "texlab", "dockerls", "tailwindcss", "bashls", "ruff_lsp", "zls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig['ltex'].setup {
  on_attach = on_attach,
  settings = {
    ltex = {
      language = "en-GB",
      disabledRules = {["en-GB"] = {"OXFORD_SPELLING_Z_NOT_S", "ARROWS", "NORTH_POLE"}, }
    }
  }
}

if not has_rust_tools then
else
  rust_tools.setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        inlayHints = { locationLinks = false },
        checkOnSave = {
          command = "clippy"
        },
        server = {
          extraEnv = {
            RUSTUP_TOOLCHAIN = "stable",
          }
        }
      },
    },
  },
})
end

--
-- local on_attach_one = function(_, bufnr)
--   -- other stuff --
--   require("tailwindcss-colors").buf_attach(bufnr)
-- end
-- lspconfig["tailwindcss"].setup({
--   on_attach = on_attach_one,
-- })
--
-- for _, lsp in ipairs(servers) do
--   local opts = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     update_in_insert = true,
--   }
--   lspconfig[lsp].setup(opts)
-- end

