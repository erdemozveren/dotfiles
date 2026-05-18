if true then
  return {}
end -- remove to work
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      -- vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Add Cursor Down"] = "<C-M-j>",
        ["Add Cursor Up"] = "<C-M-k>",
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
