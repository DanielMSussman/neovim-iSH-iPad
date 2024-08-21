return{
    {
        "epwalsh/obsidian.nvim",
        version = "*",  -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
            --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            --   -- refer to `:h file-pattern` for more examples
            --   "BufReadPre path/to/my-vault/*.md",
            --   "BufNewFile path/to/my-vault/*.md",
            -- },
            dependencies = {
                -- Required.
                "nvim-lua/plenary.nvim",

                -- see below for full list of optional dependencies 
            },
            opts = {
                workspaces = {
                    {
                        name = "sussman",
                        path = "~/repos/obsidianNotes",
                    },
                    --{
                    --    name = "work",
                    --    path = "~/vaults/work",
                    --},
                    {
                    name = "no-vault",
                    path = function()
                        -- alternatively use the CWD:
                        -- return assert(vim.fn.getcwd())
                        return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
                    end,
                    overrides = {
                        notes_subdir = vim.NIL,  -- have to use 'vim.NIL' instead of 'nil'
                        new_notes_location = "current_dir",
                        templates = {
                            folder = vim.NIL,
                        },
                        disable_frontmatter = true,
                    },
                },
            },
            disable_frontmatter = true,
            notes_subdir = "notes",
            new_notes_location = "notes_subdir",
            ui = {enable = true},
            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return suffix
            end,
            
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {
                    fname = function()
                        --return vim.fn.expand('%')
                        local temp = vim.fn.expand('%:p:h:t') .. "/" .. vim.fn. expand('%:t')
                        return temp
                    end
                },
            },
        },


    },

}
