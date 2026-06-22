# Arch Linux Dotfiles

Personal Arch Linux (Omarchy) configuration files managed with GNU Stow.

## Installation

### Default packages to install
```sh
pacman -Syu git stow kanshi keyd fd fzf ripgrep mise tmux yazi tuxedo
```

1. Clone the repository into your home directory:
   ```bash
   git clone https://github.com/erdemozveren/dotfiles ~/dotfiles
   ```

2. Navigate to the directory:
   ```bash
   cd ~/dotfiles
   ```

3. Deploy configurations by creating symlinks via Stow:
   ```bash
   stow -v tmux kanshi nvim omarchy-hypr alacritty
   # keyd needs sudo privileges to write to /etc
   sudo stow -t /etc/keyd keyd
   # Reload keyd
   sudo keyd reload
   # Install Tmux Plugin Manager
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```


## Note-Taking & Task Management
My personal setup for managing notes and tasks directly from the terminal as plain markdown files and todo.txt.

* Default Path: Notes are stored in ~/notes by default. This path can be customized in plugins/note-taking.lua.
* Navigation: It uses the [mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim) plugin to edit files and navigate between linked notes. It provides a workflow similar to VimWiki, but relies entirely on standard Markdown.
* Automatic Wiki Indexing: The setup uses a script named [generate_index.sh](./scripts/generate_index.sh). Copying this script into the notes folder allows it to scan the directory where it lives and automatically generate a wiki-style index.md file.
* Structure: Subdirectories are treated as Projects, while files in the root folder act as general, separate notes. Neovim triggers this script automatically, but it can also be run manually in the terminal.
* Todo.txt: I use external tools like [Tuxedo](https://github.com/webstonehq/tuxedo) alongside this setup to manage tasks in the todo.txt format, which can also be opened in Neovim via a keymap.
* Keymaps: I configured shortcuts using a leader key prefix to quickly open the notes `index.md` and search through the `notes` directory. You can find the exact shortcuts in plugins/note-taking.lua.

### Notes

- Neovim v0.12.2
- keyd v2.6.0
- Alacritty already installed in Omarchy (v0.17)
- tmux uses [TPM](https://github.com/tmux-plugins/tpm) for plugins (The default leader key is Alt+q)

## Disclaimer

These configurations are tailored for my specific system. Review the files before applying them to your own machine.

