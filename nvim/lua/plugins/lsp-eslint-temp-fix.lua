-- if true then
--   return {}
-- end -- remove to work
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = { eslint = {} },
    inlay_hints = { enabled = false },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" or client.name == "volar" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
