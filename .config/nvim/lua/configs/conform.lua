local options = {
  formatters_by_ft = {
    gd = { "gdformat" },
    gdscript = { "gdformat" },
    json = { "jq" },
    lua = { "stylua" },
    markdown = { "mdformat" },
    sh = { "shfmt", "shellharden" },
    yaml = { "yq" },
    zsh = { "shellharden" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
