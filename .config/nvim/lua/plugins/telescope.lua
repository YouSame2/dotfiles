-- got most of this from nvchad. just merged into 1 file

return { 'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-tree/nvim-web-devicons",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- faster sorting
  },

  cmd = "Telescope", -- cmd will lazy load Telescope
  -- according to lazy docs opts is preferred over 'config ='
  opts = function () -- wrap in function to prevent load on start

    return {
      defaults = {
        path_display = { "smart" },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },

      -- extensions_list = { "themes", "terms" },
      require('telescope').load_extension('fzf'),
    }
  end,
}
