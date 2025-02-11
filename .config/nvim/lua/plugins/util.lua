-- NOTE:
-- =================================
--          UTIL COMMANDS
--    for stuff not used often
-- =================================

return {

-- helpgrep with telescope
  "catgoose/telescope-helpgrep.nvim",
  lazy = true,
  init = function ()
    vim.api.nvim_create_user_command("Dosomething", function()
      require("lazy").load({ plugins = { "telescope-helpgrep.nvim" } }) -- Load the plugin
      require("telescope").extensions.helpgrep.helpgrep() -- Run the extension
    end, {})
  end,
  config = function ()
    require("telescope").load_extension("helpgrep")
  end,

}
