return {
    {
    "lervag/vimtex",
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
            --global vimtex settings
            vim.g.vimtex_imaps_enabled = 0 --i.e., disable them
            vim.g.vimtex_view_enabled = 0 -- i.e., that was silly

            --quickfix settings
            vim.g.vimtex_quickfix_open_on_warning = 0 --  don't open quickfix if there are only warnings
            vim.g.vimtex_quickfix_ignore_filters = {"Underfull","Overfull", "LaTeX Warning: .\\+ float specifier changed to", "Package hyperref Warning: Token not allowed in a PDF string"}
        end,
    },
}

