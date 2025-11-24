return {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        -- add any opts here
        -- this file can contain specific instructions for your project
        instructions_file = "avante.md",
        -- for example
        provider = "moonshot",
        providers = {
            moonshot = {
                endpoint = "https://api.moonshot.ai/v1",
                model = "kimi-k2-0905-preview",
                timeout = 30000, -- Timeout in milliseconds
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 32768,
                },
            },
        },
        acp_providers = {
            ["kimi-cli"] = {
                command = "kimi",
                env = {
                    KIMI_API_KEY = os.getenv("KIMI_API_KEY"),
                },
            },
        },
        web_search_engine = {
            provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
            proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "stevearc/dressing.nvim", -- for input provider dressing
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
