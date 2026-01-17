return { -- The fastest Neovim colorizer
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
    opts = {
    user_default_options = {
      names = false,
      RRGGBBAA = true,
      rgb_fn = true,
      mode = "virtualtext",
      tailwind = true,
      virtualtext = "",
      always_update = true,
    },
  },
}

