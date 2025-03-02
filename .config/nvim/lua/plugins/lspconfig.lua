return {
  "neovim/nvim-lspconfig",
  -- TODO: VeryLazy causes initial load of file to not load diagnostic and lint
  event = "VeryLazy",

  -- NOTE: order must go: mason, mason-lspconfig, blink, then lspconfig
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp", -- using blink instead
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },

  config = function()
    -- == LSP keymaps only after LSP Attach == --
    local on_attach_keys = function(_, bufnr)
      local keymap = vim.keymap
      local function opts(desc)
        return { buffer = bufnr, desc = "LSP: " .. desc }
      end
      -- keymaps
      keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts("Go to implementation (Tele)"))
      keymap.set("n", "gI", vim.lsp.buf.implementation, opts("Go to implementation"))
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts("Show references (Tele)"))
      keymap.set("n", "gR", vim.lsp.buf.references, opts("Show references"))
      keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
      keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
      keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts("List workspace folders"))
      keymap.set(
        "n",
        "<leader>ct",
        "<cmd>Telescope lsp_type_definitions<CR>",
        opts("Go to type Definition (Tele)")
      )
      keymap.set("n", "<leader>cT", vim.lsp.buf.type_definition, opts("Go to type definition"))
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
      keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts("Smart rename"))
      keymap.set("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts("show diagnostics (Tele)"))
      keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, opts("Show signature help"))
    end

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- == Configure LSP servers == --
    mason_lspconfig.setup_handlers({
      function(server_name) -- Default handler (all servers)
        lspconfig[server_name].setup({
          on_attach = on_attach_keys,
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          on_attach = on_attach_keys,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- recognize "vim" global
              },
            },
          },
        })
      end,
      -- ["emmet_ls"] = function()
      --   lspconfig["emmet_ls"].setup({
      --     capabilities = capabilities,
      --     filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      --   })
      -- end,
    })
  end,
}
