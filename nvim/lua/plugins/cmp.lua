return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			local keymap = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true, silent = true })
			end

			keymap("<C-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end)
			keymap("<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "onsails/lspkind.nvim" },

			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
			{ "windwp/nvim-autopairs" },
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")
			local autopairs = require("nvim-autopairs")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					fields = { "kind", "abbr", "menu" },

					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 20,
						ellipsis_char = "...",
						show_labelDetails = true,

						before = function(entry, vim_item)
							if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
								vim_item.menu = entry.completion_item.detail
							end

							return vim_item
						end,
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer" },
				},
			})

			autopairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
					java = false,
				},
			})

			cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},
}
