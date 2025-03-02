return {
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
}
