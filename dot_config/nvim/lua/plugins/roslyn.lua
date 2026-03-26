return { -- Roslyn LSP plugin for neovim
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    ft = { "cs", "razor" },
    opts = {},
    init = function()
        local dotnet_base = "/home/edbar/.local/share/mise/installs/dotnet"
        local dotnet_root = vim.fn.glob(dotnet_base .. "/10.*")
        if dotnet_root == "" then
            vim.notify("Roslyn: no dotnet 10.x found in " .. dotnet_base, vim.log.levels.ERROR)
            return
        end
        -- If glob returns multiple matches (newline-separated), take the last (latest)
        dotnet_root = vim.split(dotnet_root, "\n")
        dotnet_root = dotnet_root[#dotnet_root]
        vim.lsp.config("roslyn", {
            cmd_env = {
                DOTNET_ROOT = dotnet_root,
                PATH = dotnet_root .. ":" .. vim.env.PATH,
                Configuration = vim.env.Configuration or "Debug",
            },
        })
    end,
}
