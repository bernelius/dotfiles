local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.kanata = {
    install_info = {
        url = "https://github.com/postsolar/tree-sitter-kanata/",
        files = { "src/parser.c" },
        branch = "master",
    },
    filetype = "kbd",
}
