-- if true then
--   return {}
-- end -- remove to work
return {
  {
    "rguruprakash/simple-note.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("simple-note").setup({
        -- Optional Configurations
        notes_dir = "E:\\notes\\", -- default: '~/notes/'
        telescope_new = "<C-n>", -- default: <C-n>
        telescope_delete = "<C-x>", -- default: <C-x>
        telescope_rename = "<C-r>", -- default: <C-r>
        telescope_change_directory = "<C-c>", -- default: <C-c>
      })
    end,
  },
}
