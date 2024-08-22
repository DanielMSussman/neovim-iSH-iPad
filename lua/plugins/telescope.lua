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
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[f]ind [k]eymaps' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[f]ind [d]iagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[f]ind [r]esume' })
        vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[f]ind Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] [f]ind existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
}
