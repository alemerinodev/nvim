return {
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
                    ['<Tab>'] = cmp.mapping.select_next_item(),
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
                                vim_item.kind = ""
                            end
                            return vim_item
                        end
                    }),
                }
            })
        end
    }
}
