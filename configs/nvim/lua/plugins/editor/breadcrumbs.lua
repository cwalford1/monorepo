--- Show the cursor's location within nested code symbols, such as classes and functions.
--- Use nvim-navic to obtain symbol context from an attached language server.
local M = {
  "LunarVim/breadcrumbs.nvim",
  -- enables auto attach when lsp server starts.
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      opts = {
        lsp = {
          auto_attach = true,
        },
      },
    },
  },
}

function M.config()
  require("breadcrumbs").setup()
end

return M
