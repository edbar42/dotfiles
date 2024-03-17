return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies  = { 'nvim-lua/plenary.nvim' },

    config = function()
        require('harpoon').setup({})

        local harpoon = require('harpoon')

        vim.keymap.set('n', '<leader>a', function() harpoon:list():append() end)
        vim.keymap.set('n', '<leader>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end)
        vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end)
        vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end)
        vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end)
        vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end)

        -- Toggle previous & <leader>abuffers stored within Harpoon list
        vim.keymap.set('n', '<leader>aP>', function() harpoon:list():prev() end)
        vim.keymap.set('n', '<leader>aN>', function() harpoon:list():next() end)
end
}

