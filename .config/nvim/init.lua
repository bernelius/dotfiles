local tabsize = 2
vim.opt.tabstop = tabsize * 4
vim.opt.softtabstop = tabsize
vim.opt.shiftwidth = tabsize
-- tabs -> spaces
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- WSL clipboard support through win32yank
if vim.fn.has("wsl") == 1 and vim.fn.executable("win32yank.exe") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.opt.wrap = false
-- disable octal behavior for numbers with leading zero
vim.opt.nrformats = ""
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "--"

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set("i", "<leader>p", "<C-r>+")
vim.keymap.set("n", "<leader><Left>", ":bnext<CR>")
vim.keymap.set("n", "<leader><Down>", ":blast<CR>")
vim.keymap.set("n", "<leader><Up>", ":bfirst<CR>")
vim.keymap.set("n", "<leader><Right>", ":bprev<CR>")
vim.keymap.set("n", "<leader>h", ":bprev<CR>")
vim.keymap.set("n", "<leader>j", ":blast<CR>")
vim.keymap.set("n", "<leader>k", ":bfirst<CR>")
vim.keymap.set("n", "<leader>l", ":bprev<CR>")

-- Setup lazy.nvim
require("lazy").setup("plugins")

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client == nil then
--       return
--     end
--     if client.name == "ruff" then
--       -- Disable hover in favor of Pyright
--       client.server_capabilities.hoverProvider = false
--     end
--   end,
--   desc = "LSP: Disable hover capability from Ruff",
-- })

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  severity_sort = true,
  virtual_text = {
    -- virt_text_pos = "right_align",
    spacing = 10,
    -- virt_text_win_col = 100,
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})
vim.keymap.set({ "n", "v" }, "<leader>dt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.keymap.set({ "n", "v" }, "<leader>df", vim.diagnostic.open_float)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<BS>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
