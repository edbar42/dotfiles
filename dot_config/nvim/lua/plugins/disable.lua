return { -- Disabling plugins
  { "akinsho/bufferline.nvim", enabled = false },
  { "ibhagwan/fzf-lua.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = { enabled = false },
      },
    },
  },
}
