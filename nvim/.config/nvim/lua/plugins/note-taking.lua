-- TODO: This is experimental,maybe make this as seperate plugin

local notes_dir = vim.fn.expand("~/notes")
local note_leader = "<leader>\\"
local script_path = notes_dir .. "/generate_index.sh"

-- Safely executes the external bash script without passing directory arguments
local function run_shell_indexer()
  if vim.fn.filereadable(script_path) == 1 then
    vim.fn.system(script_path) -- Triggers script natively (it resolves its own directory)
  else
    -- Fallback block to ensure index.md exists if the script is deleted
    local index_path = notes_dir .. "/index.md"
    if vim.fn.filereadable(index_path) == 0 then
      vim.fn.writefile({ "# 📒 My Wiki", "", "Script not found at " .. script_path }, index_path)
    end
  end
end

-- Centralized wrapper to launch Neovim processes inside the floating window
local function launch_nvim_float(file_path)
  Snacks.terminal.open({ "nvim", file_path }, {
    cwd = notes_dir,
    win = { position = "float", height = 0.85, width = 0.85, border = "rounded" },
  })
end

-- Centralized picker configuration for searching files and text
local function open_picker(picker_type, title_text)
  Snacks.picker[picker_type]({
    cwd = notes_dir,
    title = title_text,
    win = {
      input = {
        keys = {
          ["<CR>"] = { "open_float_action", mode = { "i", "n" } }, -- Enter opens in a Float
          ["<C-v>"] = { "edit", mode = { "i", "n" } }, -- Ctrl+v opens in a standard Buffer
        },
      },
    },
    actions = {
      open_float_action = function(picker, item)
        picker:close()
        if item and item.file then
          launch_nvim_float(item.file)
        end
      end,
    },
  })
end

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "jakewvincent/mkdnflow.nvim",
    config = function()
      require("mkdnflow").setup({})

      -- This keybindings are not for mkdnflow,it just my custom wiki
      -- Open Index in a Floating Window (Triggers Bash Script)
      vim.keymap.set("n", note_leader .. "\\", function()
        run_shell_indexer()
        launch_nvim_float(notes_dir .. "/index.md")
      end, { desc = "Open Notes Index (Float)" })

      -- Open Index in a Standard Buffer (Triggers Bash Script)
      vim.keymap.set("n", note_leader .. "i", function()
        run_shell_indexer()
        vim.cmd("edit " .. notes_dir .. "/index.md")
      end, { desc = "Open Notes Index (Buffer)" })

      -- Search filenames inside notes directory
      vim.keymap.set("n", note_leader .. "n", function()
        open_picker("files", "My Notes")
      end, { desc = "Search Note Files" })

      -- Live grep text inside notes directory
      vim.keymap.set("n", note_leader .. "g", function()
        open_picker("grep", "Grep Notes")
      end, { desc = "Search Inside Notes" })

      -- Open tuxedo in notes dir
      vim.keymap.set("n", note_leader .. "t", function()
        Snacks.terminal.open({ "tuxedo", "todo.txt" }, {
          cwd = notes_dir,
          win = { position = "float", height = 0.85, width = 0.85, border = "rounded" },
        })
      end, { desc = "Open Todo.txt (Tuxedo)" })

      -- Open yazi in notes dir
      vim.keymap.set("n", note_leader .. "e", function()
        Snacks.terminal.open({ "yazi", notes_dir }, {
          cwd = notes_dir,
          win = { position = "float", height = 0.85, width = 0.85, border = "rounded" },
        })
      end, { desc = "Open Yazi In Notes Dir (Explorer)" })
    end,
  },
}
