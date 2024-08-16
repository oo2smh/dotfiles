#OTHER
alias ls="ls --color=auto"

# ALIASES
# Navigation
alias Abb="nvim ~/.config/nvim/lua/hamin/core/abbreviate.lua"
alias Zshrc="nvim ~/.zshrc"
alias Config="nvim ~/.config"
alias Nvim="nvim ~/.config/nvim"
alias Zellij="nvim ~/.config/zellij"
alias Hypr="nvim ~/.config/hypr/hyprland.conf"
alias Foot="nvim ~/.config/foot/foot.ini"
alias Star="nvim ~/.config/starship.toml"
alias Tofi="nvim ~/.config/tofi/config.ini"
alias Source="source ~/.zshrc"
alias Tasks="nvim ~/Documents/tasks"
alias Notes="nvim ~/Documents/notes/"
alias pac="sudo pacman"
alias sys="systemctl"
alias Launch="nvim ~/Developer/launch_school/"
alias Scratch="nvim ~/Documents/scratch/"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log"
alias gp="git push"
alias gd="git diff"
alias gb="git branch"

# INITALIZE
eval "$(starship init zsh)"
eval "$(zellij setup --generate-auto-start zsh)"

# SCRIPT PATH
export PATH=/home/hamin/.local/bin:$PATH

# NNN Setup
export EDITOR='nvim'
MOZ_ENABLE_WAYLAND=1

# NNN CD ON QUIT
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

# NOTES
# Sometime the arrow flips in the terminal, this means that you're in vim normal mode. Use i or a to escape
# <C-d> Exits the current session. This exits zellij if not in a nvim session.
# If in nvim, this should be pg down. Be careful with this
