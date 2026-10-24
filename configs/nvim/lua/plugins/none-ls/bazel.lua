--- Format Bazel and Starlark files with the automatically installed Buildifier tool.
return {
	{
		"neovim/nvim-lspconfig",
		opts = { tools = { "buildifier" } },
	},
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {
				function()
					return { require("null-ls").builtins.formatting.buildifier }
				end,
			},
		},
	},
}
