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

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require('lazy').setup({
    -- Telescope (find files)
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
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
            require 'nvim-treesitter.configs'.setup {
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
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        lazy = true,
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    { 'AndreM222/copilot-lualine' },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = false, -- Enable debugging
            -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
    },

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
            vim.cmd [[colorscheme tokyonight-moon]]
        end,
    },

    -- Lualine (statusline)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_b = { "grapple" },
                    lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' }
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
    { 'neovim/nvim-lspconfig' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            local cmp = require('cmp')
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['C-e'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    })
                }),
                sources = {
                    { name = "copilot",  group_index = 2 },
                    { name = "nvim_lsp", group_index = 2 }
                }
            })
        end
    },
    { 'L3MON4D3/LuaSnip' },
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp = require('lsp-zero').preset({})
            lsp.extend_lspconfig()

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false })
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
    },

    -- Rust
    {
        'rust-lang/rust.vim',
        ft = { 'rust' },
        init = function()
            vim.g.rustfmt_autosave = 1
        end
    },

    'nvim-tree/nvim-web-devicons',

    -- Show errors
    {
        "folke/trouble.nvim",
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Grapple
    {
        "cbochs/grapple.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Oil
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    },

    -- Pomodoro
    {
        "epwalsh/pomo.nvim",
        version = "*", -- Recommended, use latest release instead of latest commit
        lazy = true,
        cmd = { "TimerStart", "TimerRepeat" },
        dependencies = {
            -- Optional, but highly recommended if you want to use the "Default" timer
            "rcarriga/nvim-notify",
        },
        opts = {
            -- See below for full list of options 👇
        },
    },

    -- Obsidian
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/Obsidian Vault"
                }
            },
            daily_notes = {
                -- Optional, if you keep daily notes in a separate directory.
                folder = "daily"
            }
        }
    }
})
