return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        event = "VeryLazy",
        opts={},
        dependencies={ 'nvim-treesitter/nvim-treesitter' , 'nvim-tree/nvim-web-devicons'},
        vim.keymap.set('n', '<leader>m', ':RenderMarkdown toggle <CR>',{desc = "toggle render markdown"})
    },
}
