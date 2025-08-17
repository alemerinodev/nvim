-- BASICS
vim.g.mapleader = " "
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })

-- FORMAT
vim.keymap.set({'n', 'v'}, '<leader>cf', vim.lsp.buf.format, { desc = "Format code" })
