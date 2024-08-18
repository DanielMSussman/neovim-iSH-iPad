return {
    --a few color schemes... the default one should apparently get high priority
    {
        "rebelot/kanagawa.nvim",
        priority=1000,
        config = function()
            vim.cmd.colorscheme "kanagawa"
        end
    },

    --lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {{
                        'filename',
                        newfile_status = true,  -- Display new file status (new file means no write after created)
                        path = 1,                -- 0: Just the filename

                        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                }},
                    lualine_x = { 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'},
                },    
            })
        end
    },


}

