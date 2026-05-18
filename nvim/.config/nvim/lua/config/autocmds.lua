-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     -- Check if this is the first time the buffer is opened
--     if not vim.b.first_time_opened then
--       local clients = vim.lsp.get_active_clients({ bufnr = 0 })
--       if #clients > 0 then
--         -- Simulate file save
--         vim.api.nvim_command("doautocmd BufWritePre")
--         vim.api.nvim_command("doautocmd FileWritePre")
--         vim.api.nvim_command("doautocmd BufWriteCmd")
--         vim.api.nvim_command("doautocmd FileWriteCmd")
--         vim.api.nvim_command("doautocmd FileWritePost")
--         vim.api.nvim_command("doautocmd BufWritePost")
--         -- Mark the buffer as opened for the first time
--         -- vim.api.nvim_command("doautocmd BufWritePost")
--         vim.b.first_time_opened = true
--         vim.notify("Simulated")
--       else
--         vim.notify("LSP NOT ACTIVE")
--       end
--     end
--   end,
-- })
