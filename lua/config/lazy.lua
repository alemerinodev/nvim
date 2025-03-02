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
        -- Copilot

        -- Java LSP
        { 'L3MON4D3/LuaSnip' },
        -- Rust
        {
            'rust-lang/rust.vim',
            ft = { 'rust' },
            init = function()
                vim.g.rustfmt_autosave = 1
            end
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
            config = function()
                require('oil').setup({
                    -- Your configuration comes here
                    view_options = {
                        show_hidden = true
                    },
                })
            end,
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
