# Arch Linux Dotfiles

Personal Arch Linux (Omarchy) configuration files managed with GNU Stow.

## Installation

### Default packages to install
```sh
pacman -Syu git stow kanshi keyd fd fzf ripgrep mise tmux
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

### Notes

- Neovim v0.12.2
- keyd v2.6.0
- Alacritty already installed in Omarchy (v0.17)
- tmux uses [TPM](https://github.com/tmux-plugins/tpm) for plugins (The default leader key is Alt+q)

## Disclaimer

These configurations are tailored for my specific system. Review the files before applying them to your own machine.

