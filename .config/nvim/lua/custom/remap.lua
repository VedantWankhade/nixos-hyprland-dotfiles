local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>f', builtin.find_files, {desc='Search files'})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {desc= 'Search project files'})
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>')
vim.keymap.set('n', '<leader>y', '"+y', {desc='Yank (copy) to system clipboard'})
vim.keymap.set('n', '<leader>p', '"+p', {desc='Paste from system clipboard at cursor'})
vim.keymap.set('n', '<leader>P', '"+P', {desc='Paste from system clipboard above cursor'})
