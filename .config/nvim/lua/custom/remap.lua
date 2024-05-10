local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>f', builtin.find_files, {desc='Search files'})
vim.keymap.set('n', '<leader>p', builtin.git_files, {desc= 'Search project files'})
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>')
