--- Install debugpy automatically and configure Python debugging through nvim-dap.
return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "python" }, -- Mason package: debugpy.
      },
    },
  },
  config = function()
    -- Run the adapter in Mason's environment, independent of the project's Python.
    require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
  end,
}
