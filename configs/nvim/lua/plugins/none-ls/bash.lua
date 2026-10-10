--- Format shell scripts with shfmt using four-space indentation.
return {
	{
		"neovim/nvim-lspconfig",
		opts = { tools = { "shfmt" } },
	},
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {
				function()
					return { require("null-ls").builtins.formatting.shfmt.with({ args = { "-i", "4" } }) }
				end,
			},
		},
	},
}
