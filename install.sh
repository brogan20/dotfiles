#!/usr/bin/env bash
set -euo pipefail

OS=$(uname -s)

read -rp "Install personal tools (yt-dlp)? [y/N] " personal
personal=$(echo "$personal" | tr '[:upper:]' '[:lower:]')

if [[ "$OS" == "Linux" ]]; then
    if ! command -v pacman &>/dev/null; then
        echo "Only pacman-based Linux distros are supported." >&2
        exit 1
    fi
    sudo pacman -Syu --needed \
        zsh zsh-autosuggestions zsh-syntax-highlighting \
        neovim starship ghostty lazygit \
        fastfetch eza bat wget zoxide \
        fd fzf ripgrep git-delta ttf-firacode-nerd \
        rust-analyzer fnm
    eval "$(fnm env)"
    fnm install --lts
    npm install -g @vtsls/language-server
    if [[ "$personal" == "y" ]]; then
        sudo pacman -S --needed yt-dlp
    fi

elif [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is required. Install it from https://brew.sh, then re-run this script." >&2
        exit 1
    fi
    brew install neovim starship fastfetch eza bat wget zoxide lazygit fd fzf ripgrep git-delta \
        zsh-autosuggestions zsh-syntax-highlighting \
        rust-analyzer fnm
    brew install --cask ghostty font-fira-code-nerd-font
    eval "$(fnm env)"
    fnm install --lts
    npm install -g @vtsls/language-server
    if [[ "$personal" == "y" ]]; then
        brew install yt-dlp
    fi
    touch "$HOME/.hushlogin"

else
    echo "Unsupported OS: $OS" >&2
    exit 1
fi

# Set zsh as default shell
ZSH_PATH=$(command -v zsh)
if ! grep -qF "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$ZSH_PATH"

echo "Done. Run link.sh to symlink configs."
