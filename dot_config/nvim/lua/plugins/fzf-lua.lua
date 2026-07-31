return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>f[", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Find grep" },
    { "<leader>fG", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
  },
  opts = {
    keymap = {
      fzf = {
        ["tab"] = "down",
        ["shift-tab"] = "up",
        ["down"] = "toggle+down",
        ["up"] = "toggle+up",
      },
    },
  },
}
