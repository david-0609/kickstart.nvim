local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
-- map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
-- map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
map('n', '<leader>te', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = true })

map('n', '<leader>wp', '<cmd> ToggleWrapMode <cr>', { noremap = true, silent = true })
map('n', '<leader>uu', '<cmd> Lazy sync <cr>', { noremap = true, silent = true })

map('n', '<leader>bb', '<cmd> Navbuddy <cr>', { noremap = true, silent = true })
map('n', '<leader>zm', '<cmd> ZenMode <cr>', { noremap = true, silent = true })

-- Move.nvim
-- Normal-mode commands
map('n', '<A-j>', ':MoveLine(1)<CR>', opts)
map('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
map('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
map('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
map('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
map('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

-- Visual-mode commands
map('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
map('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
map('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
map('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

map('n', '<leader>tf', '<cmd> FSToggle <cr>', { noremap = true, silent = true })
map('n', '<leader>fn', '<cmd> Neoformat <cr>', { noremap = true, silent = true })
map('n', '<leader>lb', '<cmd> Legendary <cr>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)
