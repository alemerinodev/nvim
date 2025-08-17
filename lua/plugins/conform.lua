return {
    'stevearc/conform.nvim',
    enabled = false,
    opts = {
        formatters_by_ft = {
            java = { 'google-java-format' },
        },
        format_on_save = {
            lsp_format ="fallback",
            timeout_ms = 500,
        },
    },
}
