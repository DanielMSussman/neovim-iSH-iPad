return {
    {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build=":TSUpdate",
    config = function()
       local config = require("nvim-treesitter.configs")
        config.setup({
        ensure_installed = {"markdown", "vim", "vimdoc","markdown_inline"},
        sync_install = true,
        highlight = {enable = true,
                    disable = {"tex"},
                },
        indent = {enable = true},
        })
    end
    },
}
