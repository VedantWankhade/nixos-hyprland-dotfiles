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
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- lsp
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
	----
    -- file explorer nvim-tree
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },
    -- tabs
    {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      -- 'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
    -- statusline
    { 'nvim-lualine/lualine.nvim' }
})
