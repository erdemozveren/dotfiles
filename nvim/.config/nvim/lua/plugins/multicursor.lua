-- if true then
--   return {}
-- end -- remove to work
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 1
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Add Cursor Down"] = "<C-A-j>",
        ["Add Cursor Up"] = "<C-A-k>",
        ["Select l"] = "",
        ["Select r"] = "",
      }
    end,
    -- init = function()
    --   vim.g.VM_leader = { "ü" }
    --   vim.g.VM_maps = {
    --     ["Find Under"] = "<C-d>",
    --     ["Find Subword Under"] = "<C-d>",
    --     ["Select All"] = "<Leader>A",
    --     ["Add Cursor Down"] = "<C-Down>",
    --     ["Add Cursor Up"] = "<C-Up>",
    --     ["Visual Cursors"] = "<Leader>c",
    --   }
    -- end,
  },
}
