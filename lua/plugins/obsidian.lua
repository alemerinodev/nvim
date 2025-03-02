return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    --lazy = true,
    --ft = "markdown",
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
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
