# ----------------
# VARIABLES
# ----------------
export PATH="/usr/bin:$HOME/.mise/bin:$HOME/.local/bin/:$PATH" # prioritizes pacman installs over mise
export LESS='-R --mouse' # allows using mouse scroll with less pager
export QMK_HOME="~/.config/qmk"
export MOZ_ENABLE_WAYLAND=1 #Gives browser wayland-compatible resolution
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

## NNN
export EDITOR="nvim"
export READER="zen-browser-bin"
export NNN_TRASH="1"
export NNN_TMPFILE='/tmp/.lastd'
export NNN_BMS="\
c:/home/hamin/.config;\
d:/home/hamin/Downloads/;\
l:/home/hamin/.local/share/;\
n:/home/hamin/Dotfiles/nvim/;\
m:/home/hamin/.config/mise/;\
p:/home/hamin/.local/share/nvim/site/pack/core/opt/;\
q:/home/hamin/.config/qmk_firmware/keyboards/ferris/keymaps/default/;\
r:/home/hamin/Doc/notes/;\
s:/tmp/screenshots/;\
v:/home/hamin/Media/recordings/;\
"

# ----------------
# INITIALIZE
# ----------------
eval "$(mise activate bash)"
eval "$(starship init bash)"
eval "$(fzf --bash)" #fzf completions

# ----------------
# ALIASES: GENERAL
# ----------------
alias e='nvim .'
alias m='mise'
alias x='exit'
alias t="tmux"
alias ta="tmux a"
alias td="tmux detach"
alias ls="ls --color"
alias sys="systemctl"
alias mus='cmus ~/Media/music/'
alias cop="wl-copy"
alias py="python"
alias sou="source ~/.bashrc"
alias qmi="qmk flash -kb ferris/sweep -km default" # install
alias pac="sudo pacman"
alias par="sudo pacman -Rsu"
alias paq="sudo pacman -Qe | grep "
alias pai="sudo pacman -Qi"
alias grip="go-grip"

# KEY FILES
alias B="nvim ~/.bashrc"
alias C="nvim ~/.config"
alias D="nvim ~/Dotfiles/"
alias F="nvim ~/.config/foot/foot.ini"
alias G="nvim ~/.gitignore"
alias Gc="nvim ~/.gitconfig"
alias H="nvim ~/.config/hypr/hyprland.conf"
alias M="nvim ~/.config/mise/config.toml"
alias N="nvim ~/.config/nvim"
alias T="nvim ~/.tmux.conf"
alias Q="nvim ~/Dotfiles/qmk/"
alias R="nvim ~/Doc/notes/"

# ----------------
# GIT ALIASES
# ----------------
alias g="git"

## fugitive based alias
alias cc="git commit"
alias cvc="git commit -v"
alias ca="git commit --amend"
alias ri="git rebase -i"
alias rr="git rebase --continue"
alias ra="git rebase --abort"
alias coo="git checkout"
alias czz="git stash"
alias cza="git stash apply"
alias czp="git stash pop"

## common aliases
alias ga="git add" # (. or -p)
alias gr="git reset" # (--soft, --hard, default: --mixed)
alias gu="git restore --staged" # unstage (put file name)
alias gw="git switch"
alias gi="git --no-pager log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit"
  alias gia="git --no-pager log  --oneline --decorate --all --graph --parents"
alias gb="git --no-pager branch"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gs="git status -s" # short condensed status
  alias gss="git status"
alias go="git --no-pager show --stat --pretty=oneline"
alias gp="git push"
alias gy="git pull" # git 'yank'
alias gl='git --no-pager reflog'
alias gf="git revert"  # fix
alias gv="git --no-pager tag" # version
alias gm="git merge"

alias gd="git difftool --tool=nvimdiff --word-diff --color --ignore-all-space --color-moved"
alias gmt="git mergetool"
alias gdi="git --no-pager diff --compact-summary --ignore-all-space"
alias gds="git difftool --tool=nvimdiff --staged --no-prompt --word-diff --color-moved --ignore-all-space"

alias w="git worktree"
alias wa="git worktree add"
alias wr="git worktree remove"
alias wp="git worktree prune"
wg() {
  cd "$(git worktree list | awk '{print $1}' | fzf)" || return
}

alias ghr="gh repo"
  alias ghrl="gh repo list"
  alias ghrc="gh repo create"
alias ghp="gh pr"
alias ghpc="gh pr create"

# ----------------
# NAV ALIASES
# ----------------
# NOTE: hd = hopping. hopping depth 1, hopping to notes, hopping + edit in nvim
alias h='cd;cd "$(fd --type d --exclude Vault --exclude Media --exclude Downloads --exclude go/ | fzf)"'
alias hr='cd ~/Doc/notes && fd --type f --hidden --exclude .git \
  | fzf --preview "bat --style=numbers --color=always --line-range=1:200 {}" \
        --preview-window=right:70% \
        --bind "enter:execute(nvim {})+abort"'
alias hd='find "$HOME/Downloads" -type f -name "*.pdf" -print0 | fzf --read0 --multi | xargs -0 -r xdg-open'

he() {
  local selected_dir
  cd ~
  selected_dir=$(fd --type d --exclude go --exclude Media --exclude Downloads | fzf)
  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir" || return 1
    nvim .
  fi
}

# NNN: cd quit
n () {
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}
# ----------------
# EASE OF LIFE
# ----------------
## Make Ctrl+Backspace delete previous word (like Ctrl+W)
bind '"\C-h": backward-kill-word'
bind 'TAB:menu-complete'
bind "set colored-stats on"
bind "set menu-complete-display-prefix on"
stty -ixon # disables <C-S> which pauses the terminal
set -o ignoreeof # asks for verification with <C-D>

## Bash completion add-on
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash

# ----------------
# DOCUMENTATION
# ----------------
# https://superuser.com/questions/402246/bash-can-i-set-ctrl-backspace-to-delete-the-word-backward
## Custom keybinds
# https://superuser.com/questions/160388/change-bash-shortcut-keys-such-as-ctrl-c/1726410#1726410
# https://unix.stackexchange.com/questions/763630/map-alt-c-to-ctrl-u
# https://stackoverflow.com/questions/7179642/how-can-i-make-bash-tab-completion-behave-like-vim-tab-completion-and-cycle-thro
# [Friendly Manual] (https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html)

# ----------------
# UNUSED
# ----------------
# === SSH AGENT (single instance per login) ===
# SSH_ENV="$HOME/.ssh/agent.env"
#
# if [ -f "$SSH_ENV" ]; then
#     . "$SSH_ENV" >/dev/null
# fi
#
# if ! ssh-add -l >/dev/null 2>&1; then
#     eval "$(ssh-agent -s)" >/dev/null
#     echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$SSH_ENV"
#     echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$SSH_ENV"
#     ssh-add ~/.ssh/id_ed25519
# fi
#
