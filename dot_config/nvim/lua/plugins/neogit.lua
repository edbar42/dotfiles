return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "sindrets/diffview.nvim",
    "m00qek/baleia.nvim",
    "ibhagwan/fzf-lua",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit Status (Root Dir)" },
    { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit Status (cwd)" },
    { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit Log" },
    { "<leader>gL", "<cmd>Neogit cwd=%:p:h log<cr>", desc = "Neogit Log (cwd)" },
    { "<leader>gf", "<cmd>NeogitLogCurrent<cr>", desc = "Neogit Current File History" },
  },
  opts = {
    kind = "floating",
  },
}
