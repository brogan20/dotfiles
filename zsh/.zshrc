# Greeting
if command -v fastfetch &>/dev/null; then
  fastfetch
fi

# Environment
if command -v rg &>/dev/null; then
  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
fi

if command -v bat &>/dev/null; then
  export MANROFFOPT="-c"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# SSH agent
agent_file="$HOME/.ssh/agent.env"
if [[ -f "$agent_file" ]]; then
  source "$agent_file" > /dev/null
fi
if ! ssh-add -l > /dev/null 2>&1; then
  ssh-agent -s > "$agent_file"
  source "$agent_file" > /dev/null
fi

# Profile
if [[ -f ~/.zsh_profile ]]; then
  source ~/.zsh_profile
fi

# PATH
[[ -d ~/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d ~/Applications/depot_tools ]] && export PATH="$HOME/Applications/depot_tools:$PATH"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY        # preview !! expansion before running
setopt SHARE_HISTORY      # share history across sessions
setopt HIST_IGNORE_DUPS
setopt BANG_HIST          # enables !! and !$ expansion

alias history='fc -li 1'  # show timestamps like fish

# Completion
autoload -Uz compinit && compinit

# Functions
function backup() { cp "$1" "$1.bak" }

function copy() {
  if [[ $# -eq 2 && -d "$1" ]]; then
    cp -r "${1%/}" "$2"
  else
    command cp "$@"
  fi
}

# Aliases - ls
if command -v eza &>/dev/null; then
  alias ls='eza -al --color=always --group-directories-first --icons'
  alias la='eza -a --color=always --group-directories-first --icons'
  alias ll='eza -l --color=always --group-directories-first --icons'
  alias lt='eza -aT --color=always --group-directories-first --icons'
  alias l.="eza -a | grep -e '^\.'"
fi

# Common
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

if command -v wget &>/dev/null; then
  alias wget='wget -c '
fi

if [[ "$(uname)" == "Linux" ]]; then
  alias psmem='ps auxf | sort -nr -k 4'
  alias psmem10='ps auxf | sort -nr -k 4 | head -10'
else
  alias psmem='ps aux | sort -nr -k 4'
  alias psmem10='ps aux | sort -nr -k 4 | head -10'
fi

if command -v dir &>/dev/null; then alias dir='dir --color=auto'; fi
if command -v vdir &>/dev/null; then alias vdir='vdir --color=auto'; fi
if command -v hwinfo &>/dev/null; then alias hw='hwinfo --short'; fi

# Pacman / Arch / CachyOS
if command -v pacman &>/dev/null; then
  alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
  alias fixpacman="sudo rm /var/lib/pacman/db.lck"
  alias update='sudo pacman -Syu'
  alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
  alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
  alias apt='man pacman'
  alias apt-get='man pacman'
fi

if command -v cachyos-rate-mirrors &>/dev/null; then
  alias mirror="sudo cachyos-rate-mirrors"
fi

if command -v expac &>/dev/null; then
  alias big="expac -H M '%m\t%n' | sort -h | nl"
  alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
fi

if command -v journalctl &>/dev/null; then
  alias jctl="journalctl -p 3 -xb"
fi

if command -v yt-dlp &>/dev/null; then
  alias dlp='yt-dlp -f "bv*+ba/b" --merge-output-format mp4 -o "[%(upload_date)s] - %(title)s.%(ext)s"'
fi

# Tool integrations
if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

for _f in \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [[ -f $_f ]] && source "$_f" && break
done

for _f in \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [[ -f $_f ]] && source "$_f" && break
done
unset _f
