if true then
  return {}
end -- remove to work
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        volar = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "volar" or client.name == "ts_ls" then
              client.server_capabilities.documentFormattingProvider = false
            end
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
        end,
        -- use tsserver instead of vtsls because of bug
        vtsls = function()
          return true
        end,
        ts_ls = function()
          return true
        end,
        -- end of declaretion
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
