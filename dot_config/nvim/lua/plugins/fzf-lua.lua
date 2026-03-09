return {
  "ibhagwan/fzf-lua",
  event = "VimEnter",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", enabled = true },
  },

  config = function()
    require("fzf-lua").setup({
      winopts = {
        fullscreen = true,
        preview = {
          layout = "vertical",
          vertical = "up:70%",
        },
      },

      grep_curbuf = {
        fzf_opts = {
          ["--exact"] = "",
          ["--no-sort"] = "",
        },
      },
      files = {
        fzf_opts = {
          ["--exact"] = "",
          ["--no-sort"] = "",
        },
      },

      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },

      diagnostics = {
        cwd_only = false,
        file_icons = true,
        git_icons = true,
        color_headings = true,
        diag_icons = true,
        diag_source = true,
        diag_code = true,
        icon_padding = "",
        multiline = 2,
      },
    })

    require("fzf-lua").register_ui_select()

    local fzf = require("fzf-lua")

    vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "fzf: [S]earch [H]elp" })
    vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "fzf: [G]it [F]ile Search" })
    vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "fzf: [S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "fzf: [S]earch [F]iles" })
    vim.keymap.set("n", "<leader>fs", fzf.grep_curbuf, { desc = "fzf: [F]uzzy [S]earch the current buffer" })
    vim.keymap.set("n", "<leader>ps", fzf.live_grep, { desc = "fzf: [S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>gw", fzf.grep_cword, { desc = "fzf: [G]rep current [W]ord" })
    vim.keymap.set("n", "<leader>rc", fzf.commands, { desc = "fzf: [R]un [C]ommand" })
    vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "fzf: [ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>ch", fzf.command_history, { desc = "fzf: Browse [C]ommand [H]istory" })
    vim.keymap.set("n", "<leader>gc", fzf.git_commits, { desc = "fzf: [G]it [C]ommits with diff view" })
    vim.keymap.set("n", "<leader>bgc", fzf.git_bcommits, { desc = "fzf: Current [B]uffer's [G]it [C]ommits with diff view" })
  end,
}
