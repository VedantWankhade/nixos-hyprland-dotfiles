local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end
)
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>')
