return {
	"nvim-telescope/telescope.nvim",
	name = "telescope",
	version = false,
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = function ()
		require('telescope').setup()
	end,
}
