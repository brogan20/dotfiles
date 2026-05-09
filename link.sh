#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "  $dst -> $src"
}

echo "Linking configs..."
link "$DOTFILES/fish"                   "$HOME/.config/fish"
link "$DOTFILES/ghostty"                "$HOME/.config/ghostty"
link "$DOTFILES/nvim"                   "$HOME/.config/nvim"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/git/gitconfig"          "$HOME/.gitconfig"
link "$DOTFILES/lazygit"                "$HOME/.config/lazygit"
link "$DOTFILES/ripgrep/.ripgreprc"     "$HOME/.config/ripgrep/.ripgreprc"
echo "Done."
