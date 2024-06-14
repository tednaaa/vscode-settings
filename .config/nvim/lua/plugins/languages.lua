return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup({
				go = "go",
				goimports = "gopls",
				fillstruct = "gopls",
				gofmt = "gofumpt",
				max_line_len = 120,
				tag_transform = false,
				comment_placeholder = "",
				verbose = true,
				lsp_cfg = true,
				lsp_gofumpt = true,
				lsp_diagnostic_underline = true,
				lsp_on_attach = function(_, _) end,
				lsp_codelens = true,
				lsp_keymaps = true,
				lsp_diagnostic_hdlr = true,
				lsp_diagnostic_signs = true,
				lsp_diagnostic_update_in_insert = true,
				enable = true,
				only_current_line = false,
				only_current_line_autocmd = "CursorHold",
				show_variable_name = true,
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 6,
				highlight = "Comment",
				lsp_inlay_hints = {
					enable = true,
					style = "eol",
					only_current_line = false,
					only_current_line_autocmd = "CursorHold",
					show_variable_name = true,
					parameter_hints_prefix = "󰊕 ",
					show_parameter_hints = true,
					other_hints_prefix = "=> ",
					max_len_align = false,
					max_len_align_padding = 1,
					right_align = false,
					right_align_padding = 6,
					highlight = "Comment",
				},
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}