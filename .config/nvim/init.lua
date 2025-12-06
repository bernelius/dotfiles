local tabsize = 2
vim.opt.tabstop = tabsize * 4
vim.opt.softtabstop = tabsize
vim.opt.shiftwidth = tabsize
vim.opt.smartindent = true
-- tabs -> spaces
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.undofile = true
-- case insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

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
            { out, "WarningMsg" },
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
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("bernelius.remaps")

-- Setup lazy.nvim
require("lazy").setup("plugins")
require("lsp")

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.cmd("colorscheme catppuccin")
--vim.cmd("colorscheme yorumi")

vim.opt.winborder = "rounded"
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
            min = vim.diagnostic.severity.HINT,
        },
    },
})
