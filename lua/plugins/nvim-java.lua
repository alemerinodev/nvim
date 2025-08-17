return {
    'nvim-java/nvim-java',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    enabled = true,
    config = function()
        require('java').setup({})
        require('lspconfig').jdtls.setup({})
    end,
}
