vim.opt.termguicolors = true
return {

	gh.."theniceboy/nvim-deus",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme deus]])
-- vim.cmd([[colorscheme tokyonight]])
	end,
}