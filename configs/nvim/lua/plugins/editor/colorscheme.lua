--- Load OneDark's darker style before other plugins and customize syntax colors.
--- Apply highlight overrides for Tree-sitter, LSP semantic tokens, and traditional syntax.
return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		local onedark = require("onedark")

		onedark.setup({
			style = "darker",
			highlights = {
				["@variable"] = { fg = "$red" },
				["@constant"] = { fg = "$cyan" },
				["@boolean"] = { fg = "$orange" },
				["@variable.parameter"] = { fg = "$orange" },
				["@type"] = { fg = "$yellow" },
				["@type.builtin"] = { fg = "$yellow" },
				["@function.builtin"] = { fg = "$blue" },
				["@type.definition"] = { fg = "$yellow" },
				["@attribute"] = { fg = "$blue" },
				["@variable.member"] = { fg = "$red" },
				["@constructor"] = { fg = "$yellow" },
				["@lsp.type.variable.typescript"] = { fg = "$red" },
				["@lsp.type.variable.vue"] = { fg = "$red" },
				["javascriptIdentifier"] = { fg = "$purple" },
				["Identifier"] = { fg = "$purple" },
				["@lsp.type.variable.cpp"] = { fg = "$red" },
			},
		})
		vim.cmd("colorscheme onedark")
	end,
}
