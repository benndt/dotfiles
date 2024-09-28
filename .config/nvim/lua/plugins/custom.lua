local plugins = {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { 'CodeSnap' },
    opts = {
      watermark = "",
      bg_theme = "grape",
      bg_x_padding = 60,
      bg_y_padding = 40,
      has_breadcrumbs = true,
      has_line_number = true,
      mac_window_bar = false,
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
  {
    "m4xshen/smartcolumn.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
return plugins
