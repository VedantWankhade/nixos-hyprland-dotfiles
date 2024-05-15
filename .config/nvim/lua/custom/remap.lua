local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc='Search git files'})
vim.keymap.set('n', '<leader>fs', builtin.find_files, {desc='Search files'})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {desc= 'Search git files'})
vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<CR>', {desc="Toggle file explorer"})
vim.keymap.set('n', '<leader>ff', ':NvimTreeFocus<CR>', {desc="Focus file explorer"})
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', {desc='Open LazyGit'})
vim.keymap.set('n', '<leader>y', '"+y', {desc='Yank (copy) to system clipboard'})
vim.keymap.set('n', '<leader>p', '"+p', {desc='Paste from system clipboard at cursor'})
vim.keymap.set('n', '<leader>P', '"+P', {desc='Paste from system clipboard above cursor'})
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', {desc= 'Toggle terminal'})
vim.api.nvim_set_keymap('i', '<C-x>', 'if err != nil {\n\n}<Up><Tab>', {noremap = true, silent = true})
vim.keymap.set('n', '<A-l>', ':BufferNext<CR>', {desc= 'Next tab'})
vim.keymap.set('n', '<A-h>', ':BufferPrevious<CR>', {desc= 'Previous tab'})
vim.keymap.set('n', '<A-q>', ':BufferClose<CR>', {desc= 'Close tab'})
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', {desc= 'Toggle breakpoint'})
vim.keymap.set('n', '<leader>dr', ':DapContinue<CR>', {desc= 'Run debuger or continue'})

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n','gI', builtin.lsp_implementations, {desc='[G]oto [I]mplementation'})
