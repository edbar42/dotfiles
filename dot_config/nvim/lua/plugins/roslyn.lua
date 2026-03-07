return { -- Roslyn LSP plugin for neovim
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    ft = { "cs", "razor" },
    opts = {},
    init = function()
        local dotnet_root = "/home/edbar/.local/share/mise/installs/dotnet/10.0.102"
        vim.lsp.config("roslyn", {
            cmd_env = {
                DOTNET_ROOT = dotnet_root,
                PATH = dotnet_root .. ":" .. vim.env.PATH,
                Configuration = vim.env.Configuration or "Debug",
            },
        })
    end,
}
