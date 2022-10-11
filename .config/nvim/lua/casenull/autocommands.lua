vim.api.nvim_create_autocmd({"FileType"}, {
  -- pattern = {"*.c", "*.h"},
  callback = function()
    vim.cmd [[setlocal formatoptions-=cro]]
  end
})
