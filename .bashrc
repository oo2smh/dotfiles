# PATH for scripts
# h: ENV VARIABLES + PATH
export PATH="$PATH:$HOME/.local/opt/go/bin:$HOME/.local/bin"
export PATH=$PATH:$(pnpm root -g) # pnpm adding it to a # pnpm

export TMUX_CONFIGDIR="$HOME/.config/tmuxp"
export LESS='-R --mouse' # allows using mouse scroll with less pager
export QMK_HOME="~/.config/qmk"
MOZ_ENABLE_WAYLAND=1 #Gives browser wayland-compatible resolution

## MAN PGS
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export PNPM_HOME="/home/hamin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## NNN
export EDITOR='nvim'
export READER="zen-browser-bin"
export NNN_TRASH="1"
export NNN_BMS="d:/home/hamin/Dev/;n:/home/hamin/Doc/notes/;c:/home/hamin/.config;h:/home/hamin/;v:/home/hamin/dotfiles/nvim/"
export NNN_PLUG="K:quit" # <C-k> kills qmk
export NNN_TMPFILE='/tmp/.lastd'


# h: INITIALIZE
eval "$(direnv hook bash)"
eval "$(starship init bash)"
eval "$(fzf --bash)" #fzf completions


# h: ALIASES: Main
## Sys Cmds
alias x="exit"
alias ls="ls --color"
alias pac="sudo pacman"
alias sys="systemctl"
alias grep='grep --color=auto'
alias shutdown="sudo shutdown now"
alias suspend="systemctl suspend"
alias py="python"
alias img="wl-paste --type image/png > /tmp/screenshots/clip.png && nohup feh /tmp/screenshots/clip.png >/dev/null 2>&1 &"
alias ,="feh /tmp/screenshots"
alias ,,="feh ~/Media/screenshots"
alias open="xdg-open"
alias Source="source ~/.bashrc"
alias sa="hyprctl dispatch dpms toggle HDMI-A-1"
alias sb="hyprctl dispatch dpms toggle DP-3"
alias nm='nvim .'
alias pgcli="pgcli postgres"
alias ex="exercism"

# h: ALIASES - tmux
alias t="tmux"
alias ta="tmux a"
alias tat="tmux a -t"
alias tld="tmuxp load main" #default
alias tls="tmuxp load secondary"

# h: ALIASES - navigation
alias Dot="nvim ~/Dotfiles/"
alias Nvim="nvim ~/.config/nvim"
alias Tmux="nvim ~/.tmux.conf"


alias Config="nvim ~/.config"
alias Bash="nvim ~/.bashrc"
alias Hypr="nvim ~/.config/hypr/hyprland.conf"
alias Foot="nvim ~/.config/foot/foot.ini"
alias Qmk="nvim ~/.config/qmk/keyboards/ferris/keymaps/oo2smh/"
alias Notes="nvim ~/Doc/notes/"

## hopping
# NOTE: hd = hopping. hopping depth 1, hopping, hopping to notes, hopping + text edit
alias hd='cd "$(fd --max-depth 1 | fzf)"'
alias h="fd --type d --exclude Vault --exclude Media --exclude Downloads | fzf"
alias hn='fd --type f --hidden --full-path ~/Doc/notes/ | fzf --preview "bat --style=numbers --color=always --line-range=1:200 {}"'
ht() {
  local dir
  dir=$(fd --type d --exclude Vault --exclude Media --exclude Downloads | fzf)
  if [[ -n $dir ]]; then
    cd "$dir" && nvim .
  fi
}

# h: ALIASES:git
alias g="git"
alias gt="git tag"
alias gst="git stash"
alias gs="git status"
alias gss="git status -s" # short condensed status
alias gw="git switch"
alias gx="git checkout"
alias gr='git reflog'
alias gsh="git show --name-status --oneline"
alias gb="git branch"
alias ga="git add"
  alias gap="git add -p" # patch. can choose portions of a file to stage
alias ge="git reset" # erase..
alias gm="git merge"
alias grb="git rebase"
alias gc="git commit"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit"
  alias glp="git log --oneline --decorate --all --graph --parents"
alias gp="git push"
alias gy="git pull" # git 'yank'
alias gd="git diff --word-diff --color"
alias gds="git diff --compact-summary"
  alias gdi="git diff --staged"
  alias gdh="git diff HEAD"


# h: KEYBINDS
## Tab completion \e represents = ALT
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'

# bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind "set colored-stats on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

stty -ixon # disables <C-S> which pauses the terminal
set -o ignoreeof # asks for verification with <C-D>


# h: NNN: cd on quit
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

# h: OTHER
## Bash completion add-on
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash


# doc: REFERENCES

## Map ctrl bspc -- del word
# https://superuser.com/questions/402246/bash-can-i-set-ctrl-backspace-to-delete-the-word-backward

## Custom keybinds
# https://superuser.com/questions/160388/change-bash-shortcut-keys-such-as-ctrl-c/1726410#1726410
# https://unix.stackexchange.com/questions/763630/map-alt-c-to-ctrl-u
# https://stackoverflow.com/questions/7179642/how-can-i-make-bash-tab-completion-behave-like-vim-tab-completion-and-cycle-thro
# [Friendly Manual] (https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html)


