return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = "VeryLazy",
	opts = {},
  -- stylua: ignore
  keys = {
    {
      "]t",
      function() require("todo-comments").jump_next() end,
      desc = "Next Todo Comment"
    },
    {
      "[t",
      function() require("todo-comments").jump_prev() end,
      desc = "Previous Todo Comment"
    },
    -- TODO: check these out once trouble is setup
    -- {
    --   "<leader>xt",
    --   "<cmd>Trouble todo toggle<cr>",
    --   desc = "Todo (Trouble)"
    -- },
    -- {
    --   "<leader>xT",
    --   "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
    --   desc = "Todo/Fix/Fixme (Trouble)"
    -- },
    {
      "<leader>ft",
      "<cmd>TodoTelescope<cr>",
      desc = "Todo"
    },
    {
      "<leader>fT",
      "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
      desc = "Todo/Fix/Fixme"
    },
  },
}
