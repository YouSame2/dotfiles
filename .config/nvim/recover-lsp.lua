UnDo
K;kE
return {
  "neovim/nvim-lspconfig",
O  -- TODO: VeryLazy causes initial load of file to not load diagnostic and lint
  event = "VeryLazy",
  dependencies = {
5    -- "hrsh7th/cmp-nvim-lsp", -- using blink instead
S    {"williamboman/mason-lspconfig.nvim", opts = {automatic_installation = false}},
    -- TESTING
A    -- "williamboman/mason.nvim", -- mason-lspconfig setup inside
    'saghen/blink.cmp',
    -- TODO:
*    -- { "folke/neodev.nvim", opts = {} },
  },
  config = function()
1    -- == LSP keymaps only after LSP Attach == --
-    local on_attach_keys = function(_, bufnr)
      local keymap = vim.keymap
      local function opts(desc)
9        return { buffer = bufnr, desc = "LSP: " .. desc }
	      end
      -- keymaps
O      keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
M      keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
U      keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
\      keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
c      keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
i      keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
.      keymap.set("n", "<leader>wl", function()
@        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
*      end, opts("List workspace folders"))
^      keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
Z      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
L      keymap.set("n", "gr", vim.lsp.buf.references, opts("Show references"))
,      keymap.set("n", "<space>f", function()
+        vim.lsp.buf.format { async = true }
#      end, opts("Format document"))
    end
@    -- Change the Diagnostic symbols in the sign column (gutter)
R    local signs = { Error = "
 ", Warn = "
 ", Hint = "
 ", Info = "
 " }
%    for type, icon in pairs(signs) do
)      local hl = "DiagnosticSign" .. type
F      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
*    local lspconfig = require("lspconfig")
6    local mason_lspconfig = require("mason-lspconfig")
D    local capabilities = require("blink.cmp").get_lsp_capabilities()
%    -- == Configure LSP servers == --
$    mason_lspconfig.setup_handlers({
=      function(server_name)  -- Default handler (all servers)
&        lspconfig[server_name].setup({
%          on_attach = on_attach_keys,
&          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
#        lspconfig["lua_ls"].setup({
%          on_attach = on_attach_keys,
&          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
>                globals = { "vim" }, -- recognize "vim" global
              },
            },
          },
        })
      end,
"      -- ["emmet_ls"] = function()
(      --   lspconfig["emmet_ls"].setup({
)      --     capabilities = capabilities,
s      --     filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      --   })
      -- end,
    })
  end,
>-- TODO: take whats good credit: https://github.com/josean-dev
/-- local keymap = vim.keymap -- for conciseness
--- vim.api.nvim_create_autocmd("LspAttach", {
>--   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--   callback = function(ev)
 --     -- Buffer local mappings.
O--     -- See `:help vim.lsp.*` for documentation on any of the below functions
6--     local opts = { buffer = ev.buf, silent = true }
--     -- set keybinds
(--     opts.desc = "Show LSP references"
f--     keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
&--     opts.desc = "Go to declaration"
P--     keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
)--     opts.desc = "Show LSP definitions"
`--     keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
---     opts.desc = "Show LSP implementations"
h--     keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
.--     opts.desc = "Show LSP type definitions"
j--     keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
/--     opts.desc = "See available code actions"
--     keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
!--     opts.desc = "Smart rename"
N--     keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
,--     opts.desc = "Show buffer diagnostics"
q--     keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
*--     opts.desc = "Show line diagnostics"
a--     keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
.--     opts.desc = "Go to previous diagnostic"
e--     keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
*--     opts.desc = "Go to next diagnostic"
a--     keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
@--     opts.desc = "Show documentation for what is under cursor"
c--     keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
 --     opts.desc = "Restart LSP"
d--     keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	--   end,
-- })5
