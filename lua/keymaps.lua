vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n","<leader>p",'\"0p',{desc = 'paste last yank'})
vim.keymap.set("n","<leader>P",'\"0P',{desc = 'Paste last yank'})

vim.keymap.set("n", "<C-d>", "<C-d>zz",{desc = 'move down and center'})
vim.keymap.set("n", "<C-u>", "<C-u>zz",{desc = 'move up and center'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc ='switch the current line with the one below'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv",{desc = 'switch current  line with the one above'})

-- LSP and diagnostic section (as an autocomplete)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys,func,desc)
            vim.keymap.set('n',keys,func,{buffer = event.buf,desc='LSP: ' .. desc})
        end
        map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
        map('gD', require('telescope.builtin').lsp_definitions, '[g]oto [D]eclaration')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>ln',vim.lsp.buf.rename,'[r]e[n]ame all references to symbol')
        map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
        map('<leader>c',vim.lsp.buf.code_action,'[c]ode action')
        map('[K]',vim.lsp.buf.hover,'[K] hover information')
    end
})
vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })

vim.keymap.set('n','[d',vim.diagnostic.goto_next, {desc = 'Next warning or error'})
vim.keymap.set('n',']d',vim.diagnostic.goto_prev, {desc = 'Next warning or error'})

-- obsidian
vim.keymap.set('n','<localleader>ov',':ObsidianOpen<CR>',
    {noremap=true, desc="Obsidian: [v]iew in app"})
vim.keymap.set('n','<localleader>on',':ObsidianNew<CR>',
    {noremap=true, desc="Obsidian: [n]ew note"})
vim.keymap.set('n','<localleader>of',':ObsidianFollowLink vsplit<CR>',
    {noremap=true, desc="Obsidian: [f]ollow link in split"})
vim.keymap.set('n','<localleader>ob',':ObsidianBacklinks<CR>',
    {noremap=true, desc="Obsidian: list [b]acklinks"})
vim.keymap.set('n','<localleader>ot',':ObsidianTemplate<CR>',
    {noremap=true, desc="Obsidian: [t]emplate picker"})

vim.keymap.set('v','L',':ObsidianLinkNew<CR>',
    {noremap=true, desc="Obsidian: create new note from selected text"})

