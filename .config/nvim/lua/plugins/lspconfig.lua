return {
  "neovim/nvim-lspconfig",
  -- TODO: VeryLazy causes initial load of file to not load diagnostic and lint
  event = "VeryLazy",

  -- NOTE: order must go: mason, mason-lspconfig, blink, then lspconfig
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp", -- using blink instead
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'saghen/blink.cmp',
  },

  config = function()
    -- == LSP keymaps only after LSP Attach == --
    local on_attach_keys = function(_, bufnr)
      local keymap = vim.keymap
      local function opts(desc)
        return { buffer = bufnr, desc = "LSP: " .. desc }
      end
      -- keymaps
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
      keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
      keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
      keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
      keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
      keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
      keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts("List workspace folders"))
      keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
      keymap.set("n", "gr", vim.lsp.buf.references, opts("Show references"))
      keymap.set("n", "<space>f", function()
        vim.lsp.buf.format { async = true }
      end, opts("Format document"))
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
      function(server_name)  -- Default handler (all servers)
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



-- TODO: take whats good credit: https://github.com/josean-dev
-- 
-- local keymap = vim.keymap -- for conciseness
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--   callback = function(ev)
--     -- Buffer local mappings.
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     local opts = { buffer = ev.buf, silent = true }
--
--     -- set keybinds
--     opts.desc = "Show LSP references"
--     keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
--
--     opts.desc = "Go to declaration"
--     keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
--
--     opts.desc = "Show LSP definitions"
--     keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
--
--     opts.desc = "Show LSP implementations"
--     keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
--
--     opts.desc = "Show LSP type definitions"
--     keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
--
--     opts.desc = "See available code actions"
--     keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
--
--     opts.desc = "Smart rename"
--     keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
--
--     opts.desc = "Show buffer diagnostics"
--     keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
--
--     opts.desc = "Show line diagnostics"
--     keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
--
--     opts.desc = "Go to previous diagnostic"
--     keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
--
--     opts.desc = "Go to next diagnostic"
--     keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
--
--     opts.desc = "Show documentation for what is under cursor"
--     keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
--
--     opts.desc = "Restart LSP"
--     keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--   end,
-- })
