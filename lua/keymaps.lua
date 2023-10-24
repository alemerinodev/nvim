-- BASICS
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })

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
