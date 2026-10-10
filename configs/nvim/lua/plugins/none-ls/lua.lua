--- Format Lua with StyLua and install the formatter automatically.
return {
	{
		"neovim/nvim-lspconfig",
		opts = { tools = { "stylua" } },
	},
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {
				function()
					return { require("null-ls").builtins.formatting.stylua }
				end,
			},
		},
	},
}
