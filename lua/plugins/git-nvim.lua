return {
    -- this Pluggin allow me to run git command in neovim with :Git. Eg: :Git status
    {
        'dinhhuy258/git.nvim',
        config = function ()
            require("git").setup()
        end,
        cmd = { "Git" },
    },
}
