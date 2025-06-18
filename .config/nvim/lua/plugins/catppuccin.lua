local neo_bg = 0x121212

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 999,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			--flavour = "latte",
			color_overrides = { -- Correct option name
				mocha = {
					base = "#0f0f0f",
					mantle = "#000000",
					crust = "#000000",
				},
				latte = {
					base = "#ffffff", -- Example color for latte
					mantle = "#ffffff",
					crust = "#ffffff",
				},
			},
			highlight_overrides = {
				mocha = function(C)
					return {
						NeoTreeNormal = { bg = neo_bg }, -- Original mocha mantle: #181825
						NeoTreeNormalNC = { bg = neo_bg },
						NeoTreeEndOfBuffer = { fg = C.mantle },
						NeoTreeVertSplit = { fg = C.surface2, bg = C.base }, -- Vertical split line
            NeoTreeWinSeparator = { fg = C.surface2, bg = C.base },
						NeoTreeRootName = { fg = C.peach, bold = true },
						NeoTreeFileNameOpened = { fg = C.peach },
					}
				end,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
