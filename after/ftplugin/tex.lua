-- a set of localleader keymaps I call a lot
vim.keymap.set('n','<localleader>b',':VimtexCompileSS<CR>',{noremap=true, desc="VimTex: single-shot compile"})
    vim.keymap.set('n','<localleader>c',':VimtexCompile<CR>',{noremap=true, desc="VimTex: continuous compile"})
    vim.keymap.set('n','<localleader>Z',':VimtexStopAll<CR>',{noremap=true, desc="VimTex: stop all compilation"})

    vim.keymap.set('n','<localleader>o',':VimtexCompileSS<CR><bar>:VimtexCompileOutput<CR><bar>:wincmd J<CR><bar>:resize 10<CR>',{noremap=true, desc="VimTex: compile and see compilation log"})
    vim.keymap.set('n','<localleader>v',':VimtexView<CR>',{noremap=true, desc="VimTex: forward search"})
    
    vim.keymap.set('n','<localleader>t',':VimtexTocToggle<CR>',{noremap=true, desc="VimTex: toggle table of contents"})
    vim.keymap.set('n','<localleader>i',':VimtexInfo<CR>',{noremap=true, desc="VimTex: info"})
    vim.keymap.set('n','<localleader>x',':VimtexClean<CR>',{noremap=true, desc="VimTex: clean aux files"})
    vim.keymap.set('n','<localleader>X',':VimtexClean!<CR>',{noremap=true, desc="VimTex: clean aux files and output"})
