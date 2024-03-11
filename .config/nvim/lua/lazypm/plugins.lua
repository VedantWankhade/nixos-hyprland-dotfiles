require("lazy").setup({
	{ 
		'nvim-treesitter/nvim-treesitter', 
		tag = '0.9.2', 
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "bash", "c", "lua", "vim", "javascript", "html", "css", "go", "java", "dockerfile", "gotmpl", "json", "markdown", "nix", "proto", "templ", "typescript", "yuck" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
        		})
		end
	},
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.5' },
	{ 'nvim-lua/plenary.nvim', tag = '0.1.4' }, -- for telescope (not working with dependency option)
	{ 'nvim-tree/nvim-web-devicons', tag = '0.99' },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 }
})
