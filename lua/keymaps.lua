-- BASICS
vim.g.mapleader = " "
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', '-', "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FORMAT
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, {})

-- Markdown
vim.keymap.set("n", "<leader>md", "<CMD>MarkdownPreviewToggle<CR>")

-- Grapple
vim.keymap.set("n", "<leader>t", require("grapple").toggle)
vim.keymap.set("n", "<leader>p", require("grapple").toggle_tags)

-- Copilot chat
vim.keymap.set("n", "<leader>cp", function()
    local copilotchat = require("CopilotChat")
    require("snacks.picker").pick(copilotchat.select_prompt())
end)
local copilot = require("CopilotChat")
vim.keymap.set('n', '<leader>co', copilot.toggle)

-- Change between buffers
--vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
