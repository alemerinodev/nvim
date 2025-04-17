local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    {
        'nvim-java/nvim-java',
        dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            {
                'williamboman/mason.nvim',
                opts = {
                    registries = {
                        'github:nvim-java/mason-registry',
                        'github:mason-org/mason-registry',
                    },
                },
            }
        },
    },

    -- LSP Zero (LSP client with zero config)
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            local cmp = require('cmp')
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            local lspkind = require('lspkind')
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['C-e'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    })
                }),
                sources = {
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "supermaven", group_index = 2  },
                    { name = "copilot", group_index = 2  }
                },
                formatting = {
                    format = lspkind.cmp_format({
                        with_text = true,
                        menu = {
                            nvim_lsp = "[LSP]",
                            supermaven = "[SuperMaven]",
                            copilot = "[Copilot]"
                        },
                        before = function(entry, vim_item)
                            if entry.source.name == "copilot" then
                                vim_item.kind = ""
                            end
                            if entry.source.name == "supermaven" then
                                vim.item.kind = ""
                            end
                            return vim_item
                        end
                    }),
                }
            })
        end
    }
}
