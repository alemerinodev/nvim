-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Check if the cursor is at the beginning of the line
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require('lazy').setup({
    spec = {
        { import = "plugins" },
        -- Indent Blankline (show indentation lines)
        "lukas-reineke/indent-blankline.nvim",

        -- Copilot
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
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
            branch = "main",
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
                lspconfig.gleam.setup({})
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

        -- Obsidian
        {
            "epwalsh/obsidian.nvim",
            version = "*", -- recommended, use latest release instead of latest commit
            --lazy = true,
            --ft = "markdown",
            dependencies = {
                -- Required.
                "nvim-lua/plenary.nvim",
            },
            opts = {
                workspaces = {
                    {
                        name = "vault",
                        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"
                    }
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = "daily"
                }
            }
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
})
