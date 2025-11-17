return {
    'nvim-java/nvim-java',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    ft = { 'java' },
    config = function()
        require('java').setup({
            -- Explicitly set Java home to use SDKMAN current version
            java_home = vim.fn.expand('~/.sdkman/candidates/java/current'),
            -- Enable preview features for Java 25
            jdtls = {
                settings = {
                    java = {
                        configuration = {
                            runtimes = {
                                {
                                    name = "Java-25",
                                    path = vim.fn.expand('~/.sdkman/candidates/java/25.0.1-tem'),
                                    default = true,
                                },
                                {
                                    name = "Java-21",
                                    path = vim.fn.expand('~/.sdkman/candidates/java/21.0.8-tem'),
                                },
                                {
                                    name = "Java-17",
                                    path = vim.fn.expand('~/.sdkman/candidates/java/17.0.8-tem'),
                                },
                                {
                                    name = "Java-11",
                                    path = vim.fn.expand('~/.sdkman/candidates/java/11.0.2-open'),
                                }
                            }
                        },
                        compile = {
                            nullAnalysis = {
                                mode = "automatic"
                            }
                        },
                        eclipse = {
                            downloadSources = true,
                        },
                        maven = {
                            downloadSources = true,
                        },
                    }
                },
            },
        })
        require('lspconfig').jdtls.setup({})
        -- vim.lsp.enable('jdtls')
    end,
}
