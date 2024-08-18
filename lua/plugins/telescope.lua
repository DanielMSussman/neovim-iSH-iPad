--finding files by text string is nice...live grepping in large projects is awesome
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        --if ripgrep doesn't work, can always fall back to grep:
        --local telescope = require("telescope")
        --telescope.setup({
        --  defaults = {
        --      vimgrep_arguments = {
        --              "grep",
        --              "-,n" ,"-R","-E","-i","-s","-b","-I",
        --              },
        --              },
        --})
        builtin = require("telescope.builtin")
        vim.keymap.set('n', '<C-p>', builtin.find_files, {desc = "telescope find files"})
        vim.keymap.set('n', '<leader>fg',builtin.live_grep, {desc = "telescope liveGrep"})
    end,
}
