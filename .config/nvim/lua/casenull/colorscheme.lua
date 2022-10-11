local status, nightfox = pcall(require, "nightfox")
if (not status) then
  return
end

nightfox.setup({
  options = {
    styles = {
      -- :h attr-list
      comments = "italic",
      conditionals = "NONE",
      constants = "NONE",
      functions = "bold",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
  }
})

vim.cmd("colorscheme nightfox")
