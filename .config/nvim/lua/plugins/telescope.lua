return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- faster sorting
  },

  cmd = "Telescope", -- cmd will lazy load Telescope

  keys = {
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "[f]ind [h]elp",
    },
    {
      "<leader>fk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "[f]ind [k]eymaps",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "[f]ind [f]iles",
    },
    {
      -- find files in git root dir with fall back if no git repo
      "<leader>fF",
      function()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")

          return vim.v.shell_error == 0
        end

        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end

        local opts = {}

        if is_git_repo() then
          opts = {
            cwd = get_git_root(),
          }
        end

        require("telescope.builtin").find_files(opts)
      end,
      desc = "[f]ind [F]iles root",
    },
    {
      "<leader>f<Tab>",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "[f]ind telescope builtins",
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "[f]ind current [w]ord",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "[f]ind by [g]rep",
    },
    {
      -- find by grep in git root dir with fall back if no git repo
      "<leader>fG",
      function()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")

          return vim.v.shell_error == 0
        end

        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end

        local opts = {}

        if is_git_repo() then
          opts = {
            cwd = get_git_root(),
          }
        end

        require("telescope.builtin").live_grep(opts)
      end,
      desc = "[f]ind by [G]rep root",
    },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "[f]ind [d]iagnostics",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").resume()
      end,
      desc = "[f]ind [r]esume",
    },
    {
      "<leader>f.",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "[f]ind Recent Files",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "[f]ind [b]uffers",
    },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local config = require("telescope.config")
    ---@diagnostic disable-next-line: deprecated
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

    -- change default grep args to show hidden but not .git/
    table.insert(vimgrep_arguments, "--hidden") -- `hidden = true` is not supported in text grep commands.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        vimgrep_arguments = vimgrep_arguments,
        extensions = {
          fzf = {},
        },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          n = { ["q"] = actions.close },
          i = {
            ["<esc>"] = actions.close,
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })

    require("telescope").load_extension("fzf")
  end,
}

-- TODO: take whats good from this lazyvim config
--
-- keys = {
--     {
--       "<leader>,",
--       "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
--       desc = "Switch Buffer",
--     },
--     { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
--     { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--     { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
--     -- find
--     {
--       "<leader>fb",
--       "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
--       desc = "Buffers",
--     },
--     { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
--     { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
--     { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
--     { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
--     { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
--     { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
--     -- git
--     { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
--     { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
--     -- search
--     { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
--     { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
--     { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
--     { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--     { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
--     { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
--     { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
--     { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
--     { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
--     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
--     { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
--     { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
--     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
--     { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
--     { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
--     { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
--     { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
--     { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
--     { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
--     { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
--     { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
--     { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
--     { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
--     { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
--     {
--       "<leader>ss",
--       function()
--         require("telescope.builtin").lsp_document_symbols({
--           symbols = LazyVim.config.get_kind_filter(),
--         })
--       end,
--       desc = "Goto Symbol",
--     },
--     {
--       "<leader>sS",
--       function()
--         require("telescope.builtin").lsp_dynamic_workspace_symbols({
--           symbols = LazyVim.config.get_kind_filter(),
--         })
--       end,
--       desc = "Goto Symbol (Workspace)",
--     },
--   },
--
