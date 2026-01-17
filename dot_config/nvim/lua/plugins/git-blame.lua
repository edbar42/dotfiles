return { -- Git blame plugin for Neovim
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- for example
    enabled = true, -- if you want to enable the plugin
    message_template = " <author> • <date> • <summary>", -- template for the blame message, check the Message template section for more options
    date_format = "%r", -- template for the date, check Date format section for more options
    virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
  },
}
