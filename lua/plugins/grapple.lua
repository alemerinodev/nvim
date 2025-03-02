return {
    "cbochs/grapple.nvim",
    cmd = { "Grapple" },
    event = {"BufReadPost", "BufNewFile"},
    opt = {
        scope = "git",
    },
    keys = {
        { "<leader>t", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
        { "<leader>p", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    }
}
