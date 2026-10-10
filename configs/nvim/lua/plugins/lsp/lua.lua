--- Configure Lua completion and diagnostics for Neovim.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { "${3rd}/luv/library", unpack(vim.api.nvim_get_runtime_file("", true)) },
						},
						completion = { callSnippet = "Replace" },
						telemetry = { enable = false },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		},
	},
}
