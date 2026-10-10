--- Configure shared LSP capabilities, reference highlighting, and installation.
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"j-hui/fidget.nvim",
			tag = "v1.4.0",
			opts = {
				progress = { display = { done_icon = "✓" } },
				notification = { window = { winblend = 0 } },
			},
		},
	},
	opts_extend = { "tools", "unmanaged_servers" },
	opts = { servers = {}, tools = {}, unmanaged_servers = {} },
	config = function(_, opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local install = vim.deepcopy(opts.tools)
		local enabled = vim.tbl_keys(opts.servers)
		table.sort(enabled)
		for _, name in ipairs(enabled) do
			local server = vim.deepcopy(opts.servers[name])
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(name, server)
			if not vim.tbl_contains(opts.unmanaged_servers, name) then
				install[#install + 1] = name
			end
		end

		require("mason").setup()
		require("mason-lspconfig").setup({ automatic_enable = false })
		require("mason-tool-installer").setup({ ensure_installed = install, run_on_start = true })
		vim.lsp.enable(enabled)
	end,
}
