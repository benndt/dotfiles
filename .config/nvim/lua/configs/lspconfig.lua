require("nvchad.configs.lspconfig").defaults()

local servers = {
  "bashls",
  "gdscript",
  "gdshader_lsp",
  "lua_ls",
  "markdown_oxide",
  "typos-lsp",
  "yamlls",
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

vim.lsp.enable(servers)
