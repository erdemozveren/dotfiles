-- if true then
--   return {}
-- end -- remove to work

local jsScratchConfig = {
  keys = {
    ["source"] = {
      "<cr>",
      function(self)
        local namespace = vim.api.nvim_create_namespace("node_result")
        vim.api.nvim_buf_clear_namespace(self.buf, namespace, 0, -1)

        -- Inject script that makes console log output line numbers.
        local script = [[
                  'use strict';

                  const path = require('path');

                  ['debug', 'log', 'warn', 'error'].forEach((methodName) => {
                      const originalLoggingMethod = console[methodName];
                      console[methodName] = (firstArgument, ...otherArguments) => {
                          const originalPrepareStackTrace = Error.prepareStackTrace;
                          Error.prepareStackTrace = (_, stack) => stack;
                          const callee = new Error().stack[1];
                          Error.prepareStackTrace = originalPrepareStackTrace;
                          const relativeFileName = path.relative(process.cwd(), callee.getFileName());
                          const prefix = `${relativeFileName}:${callee.getLineNumber()}:`;
                          if (typeof firstArgument === 'string') {
                              originalLoggingMethod(prefix + ' ' + firstArgument, ...otherArguments);
                          } else {
                              originalLoggingMethod(prefix, firstArgument, ...otherArguments);
                          }
                      };
                  });
                ]]
        for _, line in pairs(vim.api.nvim_buf_get_lines(self.buf, 0, -1, true)) do
          script = script .. line .. "\n"
        end

        local result = require("plenary.job")
          :new({
            command = "node",
            args = { "-e", script },
          })
          :sync()

        if result then
          for _, line in pairs(result) do
            local line_number, output = line:match("%[eval%]:(%d+): (.*)")
            -- Subtract the lines of the injected script.
            vim.api.nvim_buf_set_extmark(0, namespace, line_number - 21, 0, {
              virt_text = { { output, "Comment" } },
            })
          end
        end
      end,
      desc = "Source buffer",
      mode = { "n", "x" },
    },
  },
}
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        -- vtsls (TypeScript) ayarları
        vtsls = {
          on_attach = function(client)
            -- Biçimlendirme yeteneğini kapat
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        -- vue_ls (Volar) ayarları
        vue_ls = {
          on_attach = function(client)
            -- Biçimlendirme yeteneğini kapat
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        -- eslint ayarları
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
    },
  },

  -- {
  --   "nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = false },
  --   },
  -- },
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      scratch = {
        win_by_ft = {
          javascript = jsScratchConfig,
          typescript = jsScratchConfig,
          vue = jsScratchConfig,
        },
      },
    },
  },

  -- {
  --   "ibhagwan/fzf-lua",
  --   opts = function(_, opts)
  --     -- Merge with existing opts
  --     opts.grep = vim.tbl_extend("force", opts.grep or {}, {
  --       -- set engine to auto
  --       rg_opts = "--engine auto",
  --     })
  --     return opts
  --   end,
  -- },
  -- its broke after last update, temporary disable
  -- { "lewis6991/gitsigns.nvim", enabled = false },
  --- mason breaking change workaround
  -- { "mason-org/mason.nvim", version = "^1.0.0" },
  -- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
