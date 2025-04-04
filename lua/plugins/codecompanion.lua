return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "gemini"
            },
            inline = {
                adapter = "gemini"
            },
            cmd = {
                adapter = "gemini"
            }
        }
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader>cp", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, noremap = true, silent = true, desc = "Open AI promt" },
        { "<leader>cc", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, noremap = true, silent = true, desc = "Open AI chat" },
        { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, noremap = true, silent = true, desc = "Open AI actions" }
    }
}
