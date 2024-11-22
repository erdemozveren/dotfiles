-- if true then
--   return {}
-- end -- remove to work
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      opts.defaults = vim.tbl_extend("force", opts.defaults or {}, {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--fixed-strings", -- This option disables regex (equivalent to --force-string)
        },
      })
    end,
  },
}
