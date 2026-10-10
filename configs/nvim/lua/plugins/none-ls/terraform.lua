--- Format Terraform files using the project's Terraform CLI.
return {
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {
				function()
					return { require("null-ls").builtins.formatting.terraform_fmt }
				end,
			},
		},
	},
}
