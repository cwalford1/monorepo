--- Lint Makefiles with the automatically installed checkmake tool.
return {
	{
		"neovim/nvim-lspconfig",
		opts = { tools = { "checkmake" } },
	},
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {
				function()
					return { require("null-ls").builtins.diagnostics.checkmake }
				end,
			},
		},
	},
}
