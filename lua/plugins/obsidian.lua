return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    --lazy = true,
    --ft = "markdown",
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Open today's note" },
        { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Open yesterday's note" },
    },
    opts = {
        workspaces = {
            {
                name = "vault",
                path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"
            }
        },
        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "daily"
        }
    }
}
