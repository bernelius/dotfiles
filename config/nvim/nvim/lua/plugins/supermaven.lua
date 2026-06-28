return {
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup({
      keymaps = {
          accept_suggestion = "<S-Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-w>",
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
          suggestion_color = "#8A8A8A",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
        condition = function()
          return string.match(vim.fn.expand("%:t"), "something.foo") --disables supermaven for files containing something.foo
        end
      })
    end,
  },
}
