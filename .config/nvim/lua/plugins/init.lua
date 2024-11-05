return {
  {
    "stevearc/conform.nvim",
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
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "gdtoolkit",
        "lua-language-server",
        "stylua",
        "yaml-language-server",
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
        "godot_resource",
        "json",
        "lua",
        "tmux",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
