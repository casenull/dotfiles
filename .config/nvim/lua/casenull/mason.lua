local status_mason, mason = pcall(require, "mason")
if (not status_mason) then
    return
end

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status_mason_lspconfig) then
    return
end

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        "ansiblels", -- Ansible
        "bashls", -- Bash
        "cssls", -- CSS
        "html", -- HTML
        "jdtls", -- Java
        "marksman", -- Markdown
        "pyright", -- Python
        "sumneko_lua",
        "texlab", -- LaTeX
        "tsserver", -- TypeScript, JavaScript
        "yamlls" -- YAML
    },
    automatic_installation = true
})
