local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {}

        if server_name == "sumneko_lua" then
            opts.settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                }
            }
        end

        if server_name == "clangd" then
            vim.cmd('let g:clangd#completions_enabled = 0')
        end

        lspconfig[server_name].setup(opts)
    end
})
