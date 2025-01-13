-- Colorscheme
return {
    "folke/tokyonight.nvim",
    enabled = false,
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
}
