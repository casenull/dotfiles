local status, bufferline = pcall(require, "bufferline")
if (not status) then
    return
end

bufferline.setup({
    options = {
        numbers = "none",
        modified_icon = "c",
        buffer_close_icon = ""
    }
})
