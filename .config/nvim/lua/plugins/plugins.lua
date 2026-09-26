-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        -- On active les suggestions car vous voulez utiliser Alt+W
        enabled = true,
        auto_trigger = true,
        -- On s'assure que Alt+W est lié à l'acceptation par mot
        keymap = {
          accept = false, -- On laisse la touche Entrée être gérée par blink.cmp
          accept_word = "<M-w>", -- Alt+W pour un mot
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-c>",
        },
      },
    },
  },
  {
    -- disable tabline
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
