## PATH for scripts
export PATH="$PATH:$HOME/.local/opt/go/bin"

# ALIASES
# =============================
## Sys Cmds
alias pac="sudo pacman"
alias sys="systemctl"
alias ls="ls --color=auto"
alias grep='grep --color=auto'
alias shutdown="sudo shutdown now"
alias suspend="systemctl suspend"
alias py="python"
alias rsp="python ~/Doc/notes/Tmp/_scratch.py"
alias rsj="python ~/Doc/notes/Tmp/_scratch.js"
alias x="exit"

## Monitor off and on
# ===========================
# sl/r = screen/monitor A and F(far)
alias sa="hyprctl dispatch dpms toggle DP-1"
alias sf="hyprctl dispatch dpms toggle DP-3"

## Zellij
alias zrp="zellij action rename-pane"
alias zr="zellij action rename-tab"
# both of these require name afterwards

## Config
### nvim
alias Dot="nvim ~/dotfiles/"
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
alias calc="rofi -show calc -modi calc -no-show-match -no-sort"

## Navigation
### Docs/Dev
alias Tasks="nvim ~/Doc/notes/Aim/_todo.md"
alias Notes="nvim ~/Doc/notes/"
alias Scratch="nvim ~/Doc/notes/Tmp/"
alias Launch="nvim ~/Dev/launch/"

## Git
alias g="git"
alias gs="git status"
alias gss="git status -s"
alias gsw="git switch"
alias gch="git checkout"
alias gsh="git show --name-status --oneline"
alias gb="git branch"
alias ga="git add"
  alias gap="git add -p"
alias gc="git commit"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit"
  alias glo="git log"
  alias glp="git log --oneline --decorate --all --graph --parents"
alias gpl="git pull"
alias gps="git push"
alias gd="git diff --word-diff --color"
alias gds="git diff --compact-summary"
  alias gdi="git diff --staged"
  alias gdh="git diff HEAD"


# INITALIZE
# =============================
eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"

## Bash completion add-on
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash
# allows you to tab complete commands (ie) git sw + TAB --> git switch

# CUSTOM KEYBINDS
# =============================
bind '"\C-j": "\C-p"' # Get prev cmd
bind '"\C-k": "\C-n"' # Get next cmd

## Tab completion \e represents = ALT
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'

bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind "set colored-stats on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

# WAYLAND SUPPORT
# =============================
MOZ_ENABLE_WAYLAND=1 #Gives firefox wayland-compatible resolution

# NNN Setup
# =============================
export EDITOR='nvim'
export READER="zen-browser-bin"

## NNN CD ON QUIT
n () {
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

# MAN COLOR
# =============================
# Colorized man
 export MANPAGER="sh -c 'col -bx | bat -l man -p'"
 export MANROFFOPT="-c"

# NOTES
# =============================
# <C-d> Exits the current session. This exits zellij if not in a nvim session.
# If in nvim, this should be pg down. Be careful with this


# REFERENCES
# =============================
## Custom keybinds
# https://superuser.com/questions/160388/change-bash-shortcut-keys-such-as-ctrl-c/1726410#1726410
# https://unix.stackexchange.com/questions/763630/map-alt-c-to-ctrl-u
# https://stackoverflow.com/questions/7179642/how-can-i-make-bash-tab-completion-behave-like-vim-tab-completion-and-cycle-thro
# [Friendly Manual] (https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html)

