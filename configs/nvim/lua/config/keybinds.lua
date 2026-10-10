--- Define editor and plugin shortcuts; attach LSP mappings only to LSP buffers.
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>c", ":Bdelete<CR>")

vim.keymap.set("n", "<leader>lj", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>lp", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

-- Debugging
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Debug: Start/Continue" })

vim.keymap.set("n", "<F1>", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })

vim.keymap.set("n", "<F2>", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })

vim.keymap.set("n", "<F3>", function()
	require("dap").step_out()
end, { desc = "Debug: Step Out" })

vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

-- Toggle the debugger UI to inspect output after a session ends.
vim.keymap.set("n", "<F7>", function()
	require("dapui").toggle()
end, { desc = "Debug: Toggle UI" })

-- Buffer navigation: the labels and mappings share the same letter assignments.
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
for letter in require("config.buffer_navigation").alphabet:gmatch(".") do
	vim.keymap.set("n", "<leader><leader>" .. letter, function()
		require("config.buffer_navigation").go_to(letter)
	end, { desc = "Go to buffer (" .. letter .. ")" })
end

-- Telescope: resolve the plugin when a picker is invoked.
for _, picker in ipairs({
	{ "<leader>ff", "find_files", "Find files" },
	{ "<leader>fg", "live_grep", "Search project text" },
	{ "<leader>fb", "buffers", "Find buffers" },
	{ "<leader>fh", "help_tags", "Find help" },
}) do
	vim.keymap.set("n", picker[1], function()
		require("telescope.builtin")[picker[2]]()
	end, { desc = "Telescope: " .. picker[3] })
end

-- Language-server shortcuts remain local to buffers with an attached client.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-keybinds", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("gd", function()
			require("telescope.builtin").lsp_definitions()
		end, "[G]oto [D]efinition")
		map("gr", function()
			require("telescope.builtin").lsp_references()
		end, "[G]oto [R]eferences")
		map("gI", function()
			require("telescope.builtin").lsp_implementations()
		end, "[G]oto [I]mplementation")
		map("<leader>D", function()
			require("telescope.builtin").lsp_type_definitions()
		end, "Type [D]efinition")
		map("<leader>ds", function()
			require("telescope.builtin").lsp_document_symbols()
		end, "[D]ocument [S]ymbols")
		map("<leader>ws", function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		end, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		map("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
	end,
})
