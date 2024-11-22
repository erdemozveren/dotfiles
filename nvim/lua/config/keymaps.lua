-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- terminal
vim.keymap.del({ "n", "t" }, "<C-/>")
vim.keymap.del({ "n", "t" }, "<C-_>")

vim.keymap.set(
  { "n", "t" },
  "<C-/>",
  "<cmd>ToggleTerm direction=horizontal <CR>",
  { desc = "Open horizontal terminal split", remap = true }
)
-- added c-_ mapped to c-/ to make it work in some terminals
vim.keymap.set(
  { "n", "t" },
  "<C-_>",
  "<cmd>ToggleTerm direction=horizontal <CR>",
  { desc = "which_key_ignore", remap = true }
)
-- vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal <CR>", { desc = "Open horizontal terminal split" })
-- vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical <CR>", { desc = "Open vertical terminal split" })

-- move lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv") -- move line down(v)

-- moving around in terminal
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- typescript tools lsp keymaps
vim.keymap.set("n", "üd", "<cmd>TSToolsGoToSourceDefinition<cr>")
vim.keymap.set("n", "üio", "<cmd>TSToolsOrganizeImports<cr>")
vim.keymap.set("n", "üis", "<cmd>TSToolsSortImports<cr>")
vim.keymap.set("n", "üir", "<cmd>TSToolsRemoveUnusedImports<cr>")
vim.keymap.set("n", "üf", "<cmd>TSToolsFixAll<cr>")
vim.keymap.set("n", "ür", "<cmd>TSToolsFileReferences<cr>")
