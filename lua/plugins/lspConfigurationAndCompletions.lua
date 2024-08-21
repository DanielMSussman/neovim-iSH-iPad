return {
    --begin by setting up plugins for language server protocols...to demonstrate I'll just focus on servers for TeX and C++
    {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
    },
    {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {}
            }
            )
    end
    },
    {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")
            --advertise cmp-nvim-lsp
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
--            lspconfig.lua_ls.setup({capabilities = capabilities,})
--            lspconfig.texlab.setup({capabilities = capabilities,})
            lspconfig.clangd.setup({capabilities = capabilities,})
    end
    },
    {
    "micangl/cmp-vimtex",
    config = function()
            local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
            if is_windows then
                require('cmp_vimtex').setup({
                    search = {
                        browser = {"start"},
                            },
                })
            else
                require('cmp_vimtex').setup({
                })
            end
    end,
    vim.keymap.set("i", "<C-s>", function() require('cmp_vimtex.search').search_menu() end)
    },
    {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
--		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
--		"hrsh7th/cmp-omni",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	    },
    event = "VeryLazy",

    config = function()
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        cmp.setup({
                snippet = {
                    expand = function(args)
                         require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                mapping = {

                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({select =true})
                            else
                                cmp.select_next_item()
                            end
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ['<C-g>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-y>'] = cmp.config.disable,
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                },

                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' }, -- not functioning (?)
                    { name = 'buffer', keyword_length = 5 }, -- completion from buffer is SLOW
                }),
                performance = {max_view_entries = 15,
                                debounce = 500,}, 
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path', option = {trailing_slash = true}, }
                }, {
                        { name = 'cmdline' , option = {treat_trailing_slash =false}}
                    }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            cmp.setup.filetype("tex", {
                sources = {
                    { name = 'vimtex' },
                    { name = 'luasnip' },
                    { name = 'buffer', keyword_length = 5 },
                },
            })
        end
    }
}
