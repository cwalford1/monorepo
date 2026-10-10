--- Install CodeLLDB automatically for C++ debugging through nvim-dap.
--- Use Mason's launch configurations to select a compiled executable, with optional arguments.
return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    ensure_installed = { "codelldb" },
  },
}
