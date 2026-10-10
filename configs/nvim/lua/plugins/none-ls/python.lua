--- Run Ruff fixes and import sorting before Ruff formatting on Python saves.
return {
	{
		"neovim/nvim-lspconfig",
		opts = { tools = { "ruff" } },
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvimtools/none-ls-extras.nvim" },
		opts = {
			sources = {
				function()
					return {
						require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
						require("none-ls.formatting.ruff_format"),
					}
				end,
			},
		},
	},
}
