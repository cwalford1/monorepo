--- Highlight TODO-style comments and navigate between Neovim splits and tmux panes.
return {
    { "folke/todo-comments.nvim", opts = {} },
    {
        "christoomey/vim-tmux-navigator",
        lazy=false,
    },
}
