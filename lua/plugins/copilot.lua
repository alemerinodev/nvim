return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    { 'AndreM222/copilot-lualine' },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = false, -- Enable debugging
        },
        keys = {
            {"<leader>co", "<cmd>CopilotChatToggle<cr>" },
        },
        build = "make tiktoken"
    }
}
