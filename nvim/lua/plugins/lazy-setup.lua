vim.opt.rtp:prepend("~/.config/nvim/lazy/lazy.nvim")

require("lazy").setup({
  -- Core dependencies
  { "nvim-lua/plenary.nvim" },

  -- LSP and Completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.lsp") -- Unified LSP + Mason config
    end,
  },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
  },
  { "quangnguyen30192/cmp-nvim-ultisnips" },
  { "SirVer/ultisnips" },

  -- none-ls (null-ls)
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.gofmt,
        },
      })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "windwp/nvim-ts-autotag" },

  -- Git
  { "f-person/git-blame.nvim" },

  -- Utilities
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end,
  },
  { "norcalli/nvim-colorizer.lua" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs-config")
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "tmhedberg/matchit" },
  { "terryma/vim-multiple-cursors" },
  { "tpope/vim-surround" },
  { "mattn/emmet-vim" },
  { "ray-x/lsp_signature.nvim" },
  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.conform")
    end,
  },

  -- Telescope
  { "nvim-telescope/telescope.nvim" },

  -- Statusline
  { "hoob3rt/lualine.nvim" },

  -- Markdown Support
  { "gabrielelana/vim-markdown" },

  -- Colorschemes
  { "folke/tokyonight.nvim" },
  { "dylanaraps/wal.vim" },
  { "navarasu/onedark.nvim" },
  { "tiagovla/tokyodark.nvim" },
  { "tanvirtin/monokai.nvim" },
  { "tomasiser/vim-code-dark" },
  { "projekt0n/github-nvim-theme" },
  { "Mofiqul/dracula.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "mcchrish/zenbones.nvim" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" },
  { "rktjmp/lush.nvim" },
  { "RRethy/base16-nvim" },
  })

