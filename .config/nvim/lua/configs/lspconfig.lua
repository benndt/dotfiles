require("nvchad.configs.lspconfig").defaults()

local servers = {
  "bashls",
  "gdscript",
  "gdshader_lsp",
  "lua_ls",
  "markdown_oxide",
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

vim.lsp.config("gdscript", {
  cmd = { "godot-wsl-lsp", "--useMirroredNetworking", "--host", "localhost" },
})

vim.lsp.enable(servers)
