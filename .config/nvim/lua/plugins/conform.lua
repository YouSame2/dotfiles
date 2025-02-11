-- credit: github.com/josean-dev
return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  -- event = { "BufReadPre", "BufNewFile" },
  -- lazy = false,
  enabled = false,
  config = function()
    local conform = require("conform")

    conform.setup({
      -- default_format_opts = function ()
      --   -- function to set the default command passing the mason dir and whatever formater is being used
      -- end,
      formatters_by_ft = {
        -- javascript = { "prettier" },
        -- typescript = { "prettier" },
        -- javascriptreact = { "prettier" },
        -- typescriptreact = { "prettier" },
        -- svelte = { "prettier" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        -- graphql = { "prettier" },
        -- liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      formatters = {
        prettier = {
          -- command = "C:\\Users\\PATRICK~1\\ Star\\AppData\\Local\\nvim-data\\mason\\bin\\prettier.cmd"
        },
        stylua = {
          -- command = "C:\\Users\\PATRICK~1\\AppData\\Local\\nvim-data\\mason\\bin\\",
        }
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })

  end,
}
