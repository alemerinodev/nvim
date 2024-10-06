-- BASICS
vim.g.mapleader = " "
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', '-', "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- TELESCOPE (navigation)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})

-- FORMAT
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, {})

-- ERRORS
local trouble = require('trouble')
vim.keymap.set('n', '<leader>ct', function() trouble.open() end, {})

-- Markdown
vim.keymap.set("n", "<leader>md", "<CMD>MarkdownPreviewToggle<CR>")

-- Grapple
vim.keymap.set("n", "<leader>t", require("grapple").toggle)
vim.keymap.set("n", "<leader>p", require("grapple").toggle_tags)

-- Copilot chat
vim.keymap.set("n", "<leader>cch", function ()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
end)
vim.keymap.set("n", "<leader>ccp", function ()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end)
vim.keymap.set("n", "<leader>ccq", function ()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
    end
end)

-- Change between buffers
--vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
