return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = {
          "^\\.git$",
          "^\\.godot$",
          "^\\.idea$",
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "gdtoolkit",
        "jq",
        "lua-language-server",
        "markdown-oxide",
        "mdformat",
        "shellharden",
        "shfmt",
        "stylua",
        "yaml-language-server",
        "yq",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "gdscript",
        "gdshader",
        "gitignore",
        "godot_resource",
        "json",
        "lua",
        "luadoc",
        "tmux",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
