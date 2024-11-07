local options = {
  formatters_by_ft = {
    bash = { "shellharden" },
    gd = { "gdformat" },
    gdscript = { "gdformat" },
    json = { "jq" },
    lua = { "stylua" },
    markdown = { "mdformat" },
    yaml = { "yq" },
    zsh = { "shellharden" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
