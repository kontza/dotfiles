return {
  { "HiPhish/rainbow-delimiters.nvim" },
  { "aklt/plantuml-syntax" },
  { "dhruvasagar/vim-table-mode" },
  {
    "stevearc/conform.nvim",
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        arduino = { "clang_format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "clang_format" },
        css = { "prettier" },
        cuda = { "clang_format" },
        go = { "gofmt", "goimports" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        html = { "prettier" },
        java = { "google_java_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        less = { "prettier" },
        lua = { "stylua" },
        proto = { "clang_format" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        scss = { "prettier" },
        svelte = { "prettier" },
        toml = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        yaml = { "prettier" },
      },
      -- Customize formatters
      formatters = {
        black = {
          prepend_args = { "--fast" },
        },
        prettier = {
          prepend_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        html = { "tidy" },
        python = { "flake8" },
      },
      linters = {
        flake8 = {
          args = {
            "--max-line-length",
            "88",
            "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
            "--no-show-source",
            "-",
          },
        },
      },
    },
  },

  { "mzlogin/vim-markdown-toc" },

  { "tpope/vim-sleuth" },

  { "khaveesh/vim-fish-syntax" },

  {
    "folke/noice.nvim",
    config = function()
      local noice = require("noice")
      noice.setup({
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").filetype_extend("svelte", { "javascript" })
      require("luasnip").filetype_extend("typescript", { "javascript" })
    end,
  },

  { "leafOfTree/vim-svelte-plugin" },

  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup({
        window = {
          border = vim.g.border_type,
        },
      })
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      server = {
        cmd = { "ra-multiplex" },
      },
    },
  },

  { "lewis6991/spaceless.nvim" },

  { "dkarter/bullets.vim" },

  { "pearofducks/ansible-vim" },

  { "lervag/wiki" },

  { "mfussenegger/nvim-jdtls" },

  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "xml",
          "php",
          "markdown",
          "astro",
          "glimmer",
          "handlebars",
          "hbs",
        },
      })
    end,
  },

  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
          never_show = {},
        },
      },
    },
  },
}
