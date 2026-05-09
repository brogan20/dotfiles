@echo off
setlocal

echo Installing packages via winget...

winget install --id Neovim.Neovim           -e --silent
winget install --id Starship.Starship        -e --silent
winget install --id ghostty.ghostty          -e --silent
winget install --id fastfetch-cli.fastfetch  -e --silent
winget install --id eza-community.eza        -e --silent
winget install --id sharkdp.bat              -e --silent
winget install --id GnuWin32.Wget            -e --silent
winget install --id ajeetdsouza.zoxide       -e --silent
winget install --id sharkdp.fd              -e --silent
winget install --id junegunn.fzf            -e --silent
winget install --id JesseDuffield.lazygit   -e --silent
winget install --id BurntSushi.ripgrep.MSVC -e --silent
winget install --id dandavison.delta        -e --silent
rem NOTE: verify this ID with `winget search "FiraCode Nerd Font"` — may not be accurate
winget install --id DEVCOM.FiraCodeNerdFont  -e --silent

set /p personal="Install personal tools (yt-dlp)? [y/N] "
if /i "%personal%"=="y" (
    winget install --id yt-dlp.yt-dlp -e --silent
)

echo Done. Symlink configs manually or adapt link.sh for WSL.
endlocal
