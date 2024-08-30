# ALIASES
# =============================
## Sys Cmds
alias pac="sudo pacman"
alias sys="systemctl"
alias ls="ls --color=auto"
alias grep='grep --color=auto'

## Zellij
alias zr="zellij action rename-pane"
alias zrt="zellij action rename-tab"
# both of these require name afterwards

## Config
### nvim
alias Nvim="nvim ~/.config/nvim"
alias Abb="nvim ~/.config/nvim/lua/hamin/core/abbreviate.lua"

### Other
alias Config="nvim ~/.config"
alias Bash="nvim ~/.bashrc"
alias Zellij="nvim ~/.config/zellij"
alias Hypr="nvim ~/.config/hypr/hyprland.conf"
alias Foot="nvim ~/.config/foot/foot.ini"
alias Star="nvim ~/.config/starship.toml"
alias Tofi="nvim ~/.config/tofi/config.ini"
alias Source="source ~/.bashrc"
alias Qmk="nvim ~/.config/qmk_firmware/keyboards/ferris/keymaps/oo2smh/"

## Navigation
### Docs
alias Tasks="nvim ~/Doc/tasks"
alias Notes="nvim ~/Doc/notes/"
alias Doc="nvim ~/Doc/faith"
alias Scratch="nvim ~/Doc/scratch/"
alias Launch="nvim ~/Dev/launch/"
alias Dsa="nvim ~/Dev/dsa/"
alias shutdown="sudo shutdown now"
alias suspend="systemctl suspend"

## Git
alias gs="git status"
alias gsw="git switch"
alias gsh="git show --name-status --oneline"
alias gb="git branch"
alias ga="git add"
alias gc="git commit"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit"
  alias glo="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  alias glp="git log --oneline --decorate --all --graph --parents"
alias gp="git push"
alias gd="git diff"
  alias gds="git diff --staged"
  alias gdh="git diff HEAD"
alias gb="git branch"

# INITALIZE
# =============================
eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"

# =============================
export PATH="$PATH:/home/hamin/.local/bin:$HOME/go/bin:"

# CUSTOM KEYBINDS
# =============================
bind '"\C-j": "\C-p"' # Get prev cmd
bind '"\C-k": "\C-n"' # Get next cmd

# WAYLAND SUPPORT
# =============================
MOZ_ENABLE_WAYLAND=1 #Gives firefox wayland-compatible resolution

# NNN Setup
# =============================
export EDITOR='nvim'

## NNN CD ON QUIT
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

# DISABLE KEYS
# =============================
stty -ixon # disables <C-S> which pauses the terminal
set -o ignoreeof # asks for verification with <C-D> which exits zellij session

# NOTES
# =============================
# <C-d> Exits the current session. This exits zellij if not in a nvim session.
# If in nvim, this should be pg down. Be careful with this


# REFERENCES
# =============================
## Custom keybinds
# https://superuser.com/questions/160388/change-bash-shortcut-keys-such-as-ctrl-c/1726410#1726410
# https://unix.stackexchange.com/questions/763630/map-alt-c-to-ctrl-u



