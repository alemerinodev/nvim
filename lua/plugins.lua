local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Telescope (find files)
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    -- Indent Blankline (show indentation lines)
    "lukas-reineke/indent-blankline.nvim",

    -- Treesitter (highlight code)
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "javascript", "lua", "vim", "vimdoc", "typescript", "go", "rust", "kotlin", "c", "cpp" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true
                }
            }
        end,
    },

    -- Copilot
    "github/copilot.vim",

    -- Colorscheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
        },
        config = function()
            require("tokyonight").setup({
                transparent = true,
            })
            vim.cmd[[colorscheme tokyonight-moon]]
        end,
    },

    -- Lualine (statusline)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_b = {
                        {
                            require("grapple").key,
                            cond = require("grapple").exists
                        }
                    }
                }
            }
        end,
    },

    -- Java LSP
    {
        'nvim-java/nvim-java',
        dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            {
                'williamboman/mason.nvim',
                opts = {
                    registries = {
                        'github:nvim-java/mason-registry',
                        'github:mason-org/mason-registry',
                    },
                },
            }
        },
    },

    -- LSP Zero (LSP client with zero config) 
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
    },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp = require('lsp-zero').preset({})
            lsp.extend_lspconfig()

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({buffer = bufnr, preserve_mappings = false})
            end)

            local lspconfig = require('lspconfig')
            require('mason').setup({})
            require('mason-lspconfig').setup({
                -- Replace the language servers listed here 
                -- with the ones you want to install
                ensure_installed = {
                    'rust_analyzer',
                    'gopls',
                    'tsserver',
                    'jdtls',
                    'kotlin_language_server',
                    'lua_ls',
                },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { 'vim' }
                                    }
                                }
                            }
                        })
                    end,
                    jdtls = function()
                        lspconfig.jdtls.setup({
                            cmd = {
                                "jdtls",
                                "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand "$MASON/share/jdtls/lombok.jar"),
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
    },

    -- Rust
    {
        'rust-lang/rust.vim',
        ft = {'rust'},
        init = function()
            vim.g.rustfmt_autosave = 1
        end
    },

    'nvim-tree/nvim-web-devicons',

    -- Show errors
    {
        "folke/trouble.nvim",
        dependencies = {{ "nvim-tree/nvim-web-devicons" }},
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Oil
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Grapple
    {
        "cbochs/grapple.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        'goolord/alpha-nvim',
        config = function ()
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end
    }
})
