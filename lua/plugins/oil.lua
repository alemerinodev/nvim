return {
    'stevearc/oil.nvim',
    opts = {
        view_options = { show_hidden = true },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "-",
            "<CMD>Oil<CR>",
            desc = "Open parent directory",
        },
    },
}
