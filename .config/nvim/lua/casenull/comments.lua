local status, comment = pcall(require, "Comment")
if (not status) then
  return
end

comment.setup({
  padding = true, -- Space between comment and line
  sticky = true, -- Keep cursor at its position
  toggler = {
    line = "gcc",
    block = "gbc"
  },
  opleader = {
    line = "gc",
    block = "gb"
  },
  extra = {
    above = "gcO",
    below = "gco",
    elo = "gcA"
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false
  },
  ignore = nil,
  pre_hook = nil,
  post_hook = nil
})

