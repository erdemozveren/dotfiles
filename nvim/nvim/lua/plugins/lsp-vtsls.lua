if true then
  return {}
end -- remove to work
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        vtsls = {
          -- Custom handler to filter out specific diagnostic codes
          on_attach = function(client, bufnr)
            -- Override the default handler for diagnostics
            client.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              if not result then
                return
              end

              -- Filter out diagnostic codes 7016 and 7046
              result.diagnostics = vim.tbl_filter(function(diagnostic)
                return diagnostic.code ~= 7016 and diagnostic.code ~= 7044 and diagnostic.code ~= 7046
              end, result.diagnostics)

              -- Call the default handler for diagnostics
              vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end
          end,
        },
      },
      -- make sure mason installs the server
      setup = {
        -- custom
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
        -- end custom
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- REMOVE THIS once this issue is fixed: https://github.com/yioneko/vtsls/issues/159
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "Could not find source",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "Request textDocument/documentHighlight failed",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
