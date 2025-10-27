return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 999,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            --flavour = "latte",
            color_overrides = {
                mocha = {
                    base = "#0f0f0f",
                    mantle = "#000000",
                    crust = "#000000",
                },
                latte = {
                    base = "#ffffff",
                    mantle = "#ffffff",
                    crust = "#ffffff",
                },
            },
        })
    end,
}
