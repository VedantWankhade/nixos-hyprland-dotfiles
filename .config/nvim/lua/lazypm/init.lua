local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazypm.plugins")
require("lazypm.lsp")

require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        barbar = true
    }
})

require('lualine').setup {
    options = {
        theme = "catppuccin",
        section_separators = { left = '', right = '' },
        component_separators = { left = ')', right = '(' }
    }
}
