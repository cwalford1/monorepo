--- Format web files, JSON, YAML, and Markdown with Prettier.
return {
	{
		"neovim/nvim-lspconfig",
		opts = { tools = { "prettier" } },
	},
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {
				function()
					return {
						require("null-ls").builtins.formatting.prettier.with({
							filetypes = { "html", "json", "yaml", "markdown", "typescript", "vue" },
						}),
					}
				end,
			},
		},
	},
}
