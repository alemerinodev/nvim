return {
    {
        "neovim/nvim-lspconfig", -- datos de configuración
    },

    {
        "mason-org/mason.nvim", -- gestor de binarios
        opts = {}
    },

        {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "jdtls" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    }
}
