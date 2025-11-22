local autocmd_group = vim.api.nvim_create_augroup("ListSortOnSave" .. vim.api.nvim_get_current_buf(), { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = autocmd_group,
  buffer = vim.api.nvim_get_current_buf(),
  callback = function()
    vim.cmd("%!sort")
  end,
  desc = "Sort 'list' file on save",
})
