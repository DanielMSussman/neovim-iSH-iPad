return {
    {"lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '-' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '_' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '-' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '_' },
                    untracked    = { text = '┆' },
                },
            })

            vim.keymap.set("n", "<leader>ch", ":Gitsigns preview_hunk<CR>", {desc = "Gitsigns: preview hunk"})
            vim.keymap.set("n", "<leader>ci", ":Gitsigns preview_hunk_inline<CR>", {desc = "Gitsigns: preview hunk inline"})
        end
    },
    {
        "tpope/vim-fugitive",
    },
}
