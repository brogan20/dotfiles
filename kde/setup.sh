#!/usr/bin/env bash
# One-time KDE configuration commands. Run manually after a fresh install.

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

# Set Ghostty as the default terminal application
kwriteconfig6 --file kdeglobals --group General --key TerminalApplication ghostty
kwriteconfig6 --file kdeglobals --group General --key TerminalService com.mitchellh.ghostty

# Override Ghostty's desktop file to remove it from the "Open Terminal Here" submenu
# (keeps "Open Terminal Here" working via kdeglobals, removes the redundant "Open in Ghostty" entry)
mkdir -p "$HOME/.local/share/applications"
ln -sfn "$DOTFILES/kde/applications/com.mitchellh.ghostty.desktop" "$HOME/.local/share/applications/com.mitchellh.ghostty.desktop"
mkdir -p "$HOME/.local/share/kio/servicemenus"
ln -sfn "$DOTFILES/kde/servicemenus/com.mitchellh.ghostty.desktop" "$HOME/.local/share/kio/servicemenus/com.mitchellh.ghostty.desktop"

kbuildsycoca6
