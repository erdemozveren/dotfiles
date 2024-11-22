return {
  -- {
  --   "Mofiqul/vscode.nvim",
  --   version = "*",
  --   -- lazy = false,
  --   -- priority = 1000,
  --   opts = {
  --     -- transparent = true,
  --   },
  -- },
  -- { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   opts = {
  --     style = "night",
  --     -- transparent = true,
  --     -- styles = {
  --     --   sidebars = "transparent",
  --     --   floats = "transparent",
  --     -- },
  --   },
  -- },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("bamboo").setup({
    --     -- optional configuration here
    --   })
    -- end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      -- vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  -- { "ful1e5/onedark.nvim", lazy = false, priority = 1000 },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "gruvbox-material",
  } },
}
