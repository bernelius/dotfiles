return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.htmldjango = {
    install_info = {
      url = "https://github.com/interdependence/tree-sitter-htmldjango",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "htmldjango",
  }
  end,
}
