## Set values
function fish_greeting
    if command -q fastfetch
        fastfetch
    end
end

if command -q rg
    set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"
end

# Format man pages with bat if available
if command -q bat
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
if test -f ~/.fish_profile
    source ~/.fish_profile
end

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Functions
# !! and !$ history expansion https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim --right --chars=/ -- $argv[1])
        set to $argv[2]
        command cp -r $from $to
    else
        command cp $argv
    end
end


## Aliases
# Replace ls with eza if available
if command -q eza
    alias ls='eza -al --color=always --group-directories-first --icons'
    alias la='eza -a --color=always --group-directories-first --icons'
    alias ll='eza -l --color=always --group-directories-first --icons'
    alias lt='eza -aT --color=always --group-directories-first --icons'
    alias l.="eza -a | grep -e '^\.'"
end

# Common use
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias please='sudo'
alias tb='nc termbin.com 9999'

if command -q wget
    alias wget='wget -c '
end

# ps forest view is Linux-only
if test (uname) = Linux
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
else
    alias psmem='ps aux | sort -nr -k 4'
    alias psmem10='ps aux | sort -nr -k 4 | head -10'
end

# GNU coreutils (not on macOS by default)
if command -q dir
    alias dir='dir --color=auto'
end
if command -q vdir
    alias vdir='vdir --color=auto'
end

if command -q hwinfo
    alias hw='hwinfo --short'
end

# Pacman / Arch / CachyOS specific
if command -q pacman
    alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
    alias fixpacman="sudo rm /var/lib/pacman/db.lck"
    alias update='sudo pacman -Syu'
    alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
    alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
    alias apt='man pacman'
    alias apt-get='man pacman'
end

if command -q cachyos-rate-mirrors
    alias mirror="sudo cachyos-rate-mirrors"
end

if command -q expac
    alias big="expac -H M '%m\t%n' | sort -h | nl"
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
end

if command -q journalctl
    alias jctl="journalctl -p 3 -xb"
end

if command -q yt-dlp
    alias dlp='yt-dlp -f "bv*+ba/b" --merge-output-format mp4 -o "[%(upload_date)s] - %(title)s.%(ext)s"'
end

if command -q starship
    starship init fish | source
end

if command -q zoxide
    zoxide init fish | source
end
