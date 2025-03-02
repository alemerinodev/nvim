return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "javascript", "lua", "vim", "vimdoc", "typescript", "go", "rust", "kotlin", "c", "cpp", "gleam", "regex" },
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
}
