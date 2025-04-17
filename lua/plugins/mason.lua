return {
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp = require('lsp-zero').preset({})
            lsp.extend_lspconfig()

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr, preserve_mappings = true })
            end)

            local lspconfig = require('lspconfig')
            require('mason').setup({})
            require('mason-lspconfig').setup({
                -- Replace the language servers listed here
                -- with the ones you want to install
                ensure_installed = {
                    'rust_analyzer',
                    'gopls',
                    'jdtls',
                    'kotlin_language_server',
                    'lua_ls',
                    'ts_ls',
                    'clangd'
                },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { 'vim', 'Snacks' }
                                    }
                                }
                            }
                        })
                    end,
                    jdtls = function()
                        lspconfig.jdtls.setup({
                            cmd = {
                                "jdtls",
                                "--jvm-arg=" ..
                                string.format("-javaagent:%s", vim.fn.expand "$MASON/share/jdtls/lombok.jar"),
                            },
                            configuration = {
                                runtimes = {
                                    {
                                        name = 'Java',
                                        path = '/Users/ale/.sdkman/candidates/java/current/bin/java',
                                    }
                                }
                            }
                        })
                    end,
                },
            })
        end,
    }
}
