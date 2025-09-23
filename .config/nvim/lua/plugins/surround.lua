return {
  "kylechui/nvim-surround",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-surround").setup({})
  end
}
