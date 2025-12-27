export PATH="$PATH:$HOME/.local/opt/go/bin:$HOME/.local/bin"

export LESS='-R --mouse' # allows using mouse scroll with less pager
export QMK_HOME="~/.config/qmk"
export MOZ_ENABLE_WAYLAND=1 #Gives browser wayland-compatible resolution

## MAN PGS
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

## NNN
export EDITOR="nvim"
export READER="zen-browser-bin"
export NNN_TRASH="1"
export NNN_BMS="l:/home/hamin/Downloads/;j:/home/hamin/Doc/notes/;c:/home/hamin/.config;h:/home/hamin/;n:/home/hamin/dotfiles/nvim/;p:/home/hamin/Dev;d:/home/hamin/Downloads"
export NNN_TMPFILE='/tmp/.lastd'

# INITIALIZE
eval "$(direnv hook bash)" # makes direnv allow for auto sourcing of venv
eval "$(starship init bash)"
eval "$(fzf --bash)" #fzf completions

# ALIASES: Main
## Sys Cmds
alias e='nvim .'
alias x="exit"
alias cop="wl-copy"
alias pas="wl-paste"
alias sou="source ~/.bashrc"
alias qmi="qmk flash" # install
alias ls="ls --color"
alias pac="sudo pacman"
alias par="sudo pacman -Rsu"
alias paq="sudo pacman -Qe | grep "
alias sys="systemctl"
alias sa="hyprctl dispatch dpms toggle HDMI-A-1"
alias sb="hyprctl dispatch dpms toggle DP-3"
alias sc="hyprctl dispatch dpms toggle DP-1"
alias pgc="pgcli postgres"
alias grep='grep --color=auto'
alias grip="go-grip"

# ALIASES - tmux
alias t="tmux"
alias ta="tmux a"
alias tat="tmux a -t"

# ALIASES - navigation
alias D="nvim ~/Dotfiles/"
alias N="nvim ~/.config/nvim"
alias T="nvim ~/.tmux.conf"
alias C="nvim ~/.config"
alias B="nvim ~/.bashrc"
alias H="nvim ~/.config/hypr/hyprland.conf"
alias F="nvim ~/.config/foot/foot.ini"
alias Q="nvim ~/Dotfiles/qmk/"
alias R="nvim ~/Doc/notes/"
alias K="nvim ~/Doc/notes/etc/keys/"

## hopping
# NOTE: hd = hopping. hopping depth 1, hopping to notes, hopping + edit in nvim
alias h='cd;cd "$(fd --type d --exclude Vault --exclude Media --exclude Downloads | fzf)"'
alias hr='cd ~/Doc/notes && fd --type f --hidden --exclude .git \
  | fzf --preview "bat --style=numbers --color=always --line-range=1:200 {}" \
        --preview-window=right:70% \
        --bind "enter:execute(nvim {})+abort"'
alias hd='find "$HOME/Downloads" -type f -name "*.pdf" -print0 | fzf --read0 --multi | xargs -0 -r xdg-open'

# ALIASES:git
alias g="git"
alias gt="git --no-pager tag"
alias gst="git stash"
alias gsti="git --no-pager stash list"
alias gs="git status"
alias gss="git status -s" # short condensed status
alias gw="git switch"
alias g.="git worktree"
alias g.l="git worktree list"
alias gwc="git switch -c"
alias gx="git checkout"
alias gr='git --no-pager reflog'
alias gsh="git --no-pager show --stat --pretty=oneline"
alias gshow="git --no-pager show --stat"
alias gb="git --no-pager branch"
alias gba="git --no-pager branch -r" # lists remote too
alias gbd="git --no-pager branch -d"
alias gbD="git --no-pager branch -D"
alias ga="git add"
alias ga.="git add ."
  alias gap="git add -p" # patch. can choose portions of a file to stage
alias gu="git reset --soft" # undo soft..
alias gum="git reset --mixed" # undo mixed..
alias guh="git reset --hard" # undo hard..
alias guv="git revert"  # revert undo

# git modify/mold the commit history
alias gmm="git merge"
alias gmr="git rebase"
alias gmrr="git rebase --continue"
alias gc="git commit -v" # verbose adds the diff to the description of commit
alias gi="git --no-pager log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit"
  alias gia="git --no-pager log  --oneline --decorate --all --graph --parents"
alias gp="git push"
alias gy="git pull" # git 'yank'
alias g,="git --no-pager diff --word-diff --color --ignore-all-space --color-moved"
  alias g,c="git --no-pager diff --compact-summary --ignore-all-space"
  alias g,s="git --no-pager diff --staged --word-diff --color-moved --ignore-all-space"

# g,: shows unstaged changes
  # g,c: compact unstaged changes
  # g,s: shows staged changes
  # g, <ref> <ref>
    # choose 2 refs (commit, branch, tag, relative pointer HEAD) to compare
  # g, <ref> <ref> -- <file/folder>  ||> g, -- <file/folder>
    # filters the changes to the specified file/folder


# git show <commit> is like a shorthand for:
# - git commit metadata
# - git diff <parent commit> <current commit>

# ----
alias ghr="gh repo"
alias ghp="gh repo"
alias ghrl="gh repo list"
alias ghrc="gh repo create"
alias ghprc="gh pr create"

# KEYBINDS
## Tab completion \e represents = ALT
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'

# bind "set show-all-if-ambiguous on"
bind "set colored-stats on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

stty -ixon # disables <C-S> which pauses the terminal
set -o ignoreeof # asks for verification with <C-D>

# GRIP TO PDF

# NNN: cd quit
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

# OTHER
## Bash completion add-on
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash

# doc: REFERENCES

# https://superuser.com/questions/402246/bash-can-i-set-ctrl-backspace-to-delete-the-word-backward

## Custom keybinds
# https://superuser.com/questions/160388/change-bash-shortcut-keys-such-as-ctrl-c/1726410#1726410
# https://unix.stackexchange.com/questions/763630/map-alt-c-to-ctrl-u
# https://stackoverflow.com/questions/7179642/how-can-i-make-bash-tab-completion-behave-like-vim-tab-completion-and-cycle-thro
# [Friendly Manual] (https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html)

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Start SSH agent if not running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Add key quietly
ssh-add -q ~/.ssh/id_ed25519


