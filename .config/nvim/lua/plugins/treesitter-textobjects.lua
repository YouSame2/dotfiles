-- credit: mostly from: github.com/josean-dev but also part from lazyvim
-- NOTE: mini.ai suppossedly will conflict with textobjects, if using mini.ai either disable or double check keymaps.
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {"nvim-treesitter/nvim-treesitter"},
  event = "VeryLazy",

  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            -- ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            -- ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            -- ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            -- ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
            -- ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
            -- ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
            -- ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
            -- ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

            -- ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            -- ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            -- ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            -- ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            -- ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            -- ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            -- ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
            -- ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

            -- ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
            -- ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

            -- ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
            -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
          },
        },
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
        --     ["<leader>n:"] = "@property.outer", -- swap object property with next
        --     ["<leader>nm"] = "@function.outer", -- swap function with next
        --   },
        --   swap_previous = {
        --     ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
        --     ["<leader>p:"] = "@property.outer", -- swap object property with prev
        --     ["<leader>pm"] = "@function.outer", -- swap function with previous
        --   },
        -- },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        },
      },
    })

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
