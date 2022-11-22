local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_status then
    return
end

local dap_ui_status, dap_ui = pcall(require, "dapui")
if not dap_ui_status then
    return
end

local dap_virtual_text_status, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not dap_virtual_text_status then
    return
end

vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})

mason_dap.setup({
    ensure_installed = {
        "javadbg",
        "javatest",
        "python",
        "js",
    },
    automatic_setup = true
})

mason_dap.setup_handlers({
    -- Default Configuration
    function (source_name)
        require("mason-nvim-dap.automatic_setup")(source_name)
    end,
})

dap_ui.setup({
    layouts = {
        {
            elements = {
                { id = "console", size = 0.65 },
                { id = "repl", size = 0.35 },
            },
            size = 0.25,
            position = "bottom",
        },
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 0.2,
            position = "right",
        },
    },
})

dap_virtual_text.setup({})
