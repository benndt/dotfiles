-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "bashls",
  "gdshader_lsp",
  "lua_ls",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.gdscript.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "godot-wsl-lsp", "--useMirroredNetworking", "--host", "localhost" },
})
