return {
    'nvim-java/nvim-java',
    enabled = false, -- disable because don't work yet with mason 2.0
    config = function()
        require("java").setup()
    end,
    priority = 1000,
}
