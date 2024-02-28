-- leader
vim.g.mapleader = " "

-- netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- move selected up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- improved yanking
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- vertical selection
vim.keymap.set("n", "<leader>v", "<C-v>")

-- buffer operations
-- previous buffer
vim.keymap.set("n", "<leader>bp", "<C-^>")
-- diretional
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})
-- split vertical
vim.keymap.set("n", "<leader>bv", "<cmd>vs<cr>", {})
vim.keymap.set("n", "<leader>Bv", "<cmd>vs", {})
-- split horizontal
vim.keymap.set("n", "<leader>bh", "<cmd>split<cr>", {})
vim.keymap.set("n", "<leader>Bh", "<cmd>split", {})


-- telescope
-- find files
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", {})
-- find git files
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", {})
-- find buffers
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
-- live grep
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope live_grep<cr>", {})

-- telescope-undo
-- undo tree
vim.keymap.set("n", "<leader>ut", "<cmd>Telescope undo<cr>", {})

-- lazy
-- lazy vim
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", {})

-- fugitive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", {})

-- treesitter
vim.keymap.set("n", "<leader>tsi", "<cmd>TSInstallInfo<cr>", {})

-- mason
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", {})

-- go to neovim config
vim.keymap.set("n", "<leader>config", "<cmd>e ~/.config/nvim/lua<cr>", {})

-- codeium
vim.keymap.set("i", "<C-s>", function () return vim.fn['codeium#Complete']() end, {expr = true, silent = true})
vim.keymap.set("i", "<C-Space>", function () return vim.fn['codeium#Accept']() end, {expr = true, silent = true})
vim.keymap.set("i", "<C-c>", function () return vim.fn['codeium#Clear']() end, {expr = true, silent = true})
vim.keymap.set("i", "<C-l>", function () return vim.fn['codeium#CycleCompletions'](1) end)
vim.keymap.set("i", "<C-h>", function () return vim.fn['codeium#CycleCompletions'](-1) end)

-- trouble
vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
