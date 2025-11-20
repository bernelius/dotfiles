return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        debounce = 200,
        -- indent = { char = "|" },
        whitespace = { highlight = { "Whitespace", "NonText" } },
        scope = { exclude = { language = { "json" } }, highlight = { "Keyword" } },
    },
}
