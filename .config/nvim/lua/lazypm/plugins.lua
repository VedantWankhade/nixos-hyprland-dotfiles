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
	{ 'nvim-tree/nvim-web-devicons' },
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
        config = function()
        require("nvim-tree").setup {}
      end,
    },
    -- git 
    { 'lewis6991/gitsigns.nvim', config = function() require("gitsigns").setup() end },
    -- tabs
    {'romgrk/barbar.nvim',
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
    { 'nvim-lualine/lualine.nvim' },
    -- codeium
    --{
    --  'Exafunction/codeium.vim',
    --   event = 'BufEnter'
    --}
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
	    'numToStr/Comment.nvim',
	    opts = {
	    },
	    lazy = false,
	},
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    -- nvim v0.8.0
    {
        {
            "kdheepak/lazygit.nvim",
            cmd = {
                "LazyGit",
                "LazyGitConfig",
                "LazyGitCurrentFile",
                "LazyGitFilter",
                "LazyGitFilterCurrentFile",
            },
            -- optional for floating window border decoration
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            -- setting the keybinding for LazyGit with 'keys' is recommended in
            -- order to load the plugin when the command is run for the first time
            keys = {
               { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
            }
        },
    }
})
