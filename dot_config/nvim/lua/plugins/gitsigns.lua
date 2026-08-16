return {
  "lewis6991/gitsigns.nvim",
  keys = {
    { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Git Blame Line" },
  },
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
    },
  },
}
