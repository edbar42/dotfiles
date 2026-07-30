return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>f[", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
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
