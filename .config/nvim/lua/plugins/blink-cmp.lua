return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  -- TODO: look into luasnips
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- { 'L3MON4D3/LuaSnip', version = 'v2.*' }, -- not using luaSnip
  },
  version = "*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      -- add any filetypes to disable cmp here
      local disabled_filetypes = {
        TelescopePrompt = true, -- speed up telescope
        markdown = true,
        -- minifiles = true,
        -- snacks_picker_input = true,
      }
      -- check if command mode is a shell cmd (i.e. [ ":!" , ":%!" ]) to disable cmp for proformance
      local function not_shellcmd()
        if vim.fn.getcmdtype() ~= ":" then -- speed optimization for searches
          return true
        else
          return not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
        end
      end
      return not disabled_filetypes[vim.bo[0].filetype]
          -- and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
          and not_shellcmd()
    end,

    keymap = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      preset = "default",
      -- TODO: these keybinds confict with something, find out what
      ["<C-d>"] = { "show", "show_documentation", "hide_documentation", "fallback" }, -- should be C-Space
      -- NOTE: other keybinds to look into:
      --
      -- "scroll_documentation_up", "scroll_documentation_down"
      --
      -- ['<Tab>'] = {
      --   function(cmp)
      --     if cmp.snippet_active() then return cmp.accept()
      --     else return cmp.select_and_accept() end
      --   end,
      --   'snippet_forward',
      --   'fallback'
      -- },
      -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    completion = {
      list = {
        selection = { preselect = true, auto_insert = false },
      },
      -- keyword range doc:
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before *and* after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = {
        range = "full",
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- snippets = { preset = 'luasnip' }, -- not using luaSnip

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
  },
  opts_extend = { "sources.default" },
}
