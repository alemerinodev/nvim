return {
    'rebelot/kanagawa.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
    },
    config = function()
        require("kanagawa").setup({
            theme = "wave",
            transparent = true,
            colors = {
                theme = { all = { ui = { bg_gutter = 'none' }  }}
            }
        })
        vim.cmd [[colorscheme kanagawa]]
    end,
}
