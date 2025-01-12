
return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	opts = {
		indent = {
			char = '▏',
		},
		scope = {
			enabled = true,
			char = '▎',
			highlight = 'CursorLineNr',
			show_start = true,
			show_end = true,
			show_exact_scope = false,
			include = {
				node_type = { ["*"] = { "*" } },
			},
		},
		exclude = {
			filetypes = {
				'help',
				'startify',
				'dashboard',
				'packer',
				'neogitstatus',
				'NvimTree',
				'Trouble',
				-- 'neo-tree',
			},
		},
	},
}
