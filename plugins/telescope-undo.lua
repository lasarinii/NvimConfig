return {
	'debugloop/telescope-undo.nvim',
	name = 'telescope-undo',
	config = function ()
		require('telescope').load_extension('undo')
	end,
}
