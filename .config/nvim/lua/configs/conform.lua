local options = {
  formatters_by_ft = {
    gd = { "gdformat" },
    gdscript = { "gdformat" },
    gdshader = { "clang-format" },
    json = { "jq" },
    lua = { "stylua" },
    markdown = { "rumdl" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
