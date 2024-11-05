local options = {
  formatters_by_ft = {
    gd = { "gdformat" },
    gdscript = { "gdformat" },
    json = { "yq" },
    lua = { "stylua" },
    yaml = { "yq" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
