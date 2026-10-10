--- Display the statusline with Git diff counts and the active Python virtual environment.
local function python_env()
	if vim.bo.filetype == "python" then
		local venv = os.getenv("VIRTUAL_ENV")
		if venv then
			local icons = require("nvim-web-devicons")
			local py_icon = icons.get_icon("env.py", "py") or "Python"
			local name = vim.fn.fnamemodify(venv:gsub("/+$", ""), ":t")
			return string.format(" %s (%s)", py_icon, name)
		end
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = {
			lualine_c = { "diff", python_env },
		},
	},
}
