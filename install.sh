#!/usr/bin/env bash
set -euo pipefail

OS=$(uname -s)

read -rp "Install personal tools (yt-dlp)? [y/N] " personal
personal="${personal,,}"

if [[ "$OS" == "Linux" ]]; then
    if ! command -v pacman &>/dev/null; then
        echo "Only pacman-based Linux distros are supported." >&2
        exit 1
    fi
    sudo pacman -Syu --needed \
        fish neovim starship ghostty lazygit \
        fastfetch eza bat wget zoxide \
        fd fzf ripgrep ttf-firacode-nerd
    if [[ "$personal" == "y" ]]; then
        sudo pacman -S --needed yt-dlp
    fi

elif [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is required. Install it from https://brew.sh, then re-run this script." >&2
        exit 1
    fi
    brew install fish neovim starship fastfetch eza bat wget zoxide lazygit fd fzf ripgrep
    brew install --cask ghostty font-fira-code-nerd-font
    if [[ "$personal" == "y" ]]; then
        brew install yt-dlp
    fi

else
    echo "Unsupported OS: $OS" >&2
    exit 1
fi

# Set fish as default shell
FISH_PATH=$(command -v fish)
if ! grep -qF "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$FISH_PATH"

echo "Done. Run link.sh to symlink configs."
