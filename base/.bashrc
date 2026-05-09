# ----------------
# VARIABLES
# ----------------
export PATH="/usr/bin:$HOME/.mise/bin:$HOME/.local/bin/:$HOME/go/bin:$PATH:/opt/homebrew/opt/trash-cli/bin:$PATH"
export QMK_HOME="~/.config/qmk"
export LESS='-R --mouse' # allows using mouse scroll with less pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export TUCKR_DIR="$HOME/dotfiles"

export BASH_SILENCE_DEPRECATION_WARNING=1

## NNN
export EDITOR="nvim"
export NNN_F_REN=1
export READER="helium.desktop"
export NNN_TRASH="1"
export NNN_TMPFILE='/tmp/.lastd'
export NNN_OPENER="xdg-open"
export NNN_PLUG='t:fzcd;'
export FZF_DEFAULT_COMMAND='fd --type d --hidden --exclude "{.wine,.cache,Trash,.git,node_modules,qmk}" --search-path ~/Dev --search-path ~/Downloads --search-path ~/Dotfiles --search-path ~/.local --search-path ~/.config'
export NNN_BMS="\
b:$HOME/.local/bin;\
c:$HOME/.config;\
d:$HOME/Downloads/;\
l:$HOME/.local/share/;\
i:$HOME/Media/icons/tabler/filled;\
n:$HOME/dotfiles/nvim/;\
m:$HOME/.config/mise/;\
p:$HOME/.local/share/nvim/site/pack/core/opt/;\
q:$HOME/.config/qmk_firmware/keyboards/ferris/keymaps/default/;\
r:$HOME/Doc/notes/;\
s:/tmp/screenshots/;\
v:$HOME/Media/recordings/;\
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
alias ob='obs-cli recording toggle && notify-send "OBS Recording toggled"'
alias cop="wl-copy"
alias acop="pbcopy"
alias sou="source ~/.bashrc"
alias soap="source .venv/bin/activate"
alias qmi="qmk flash -kb ferris/sweep -km main"
alias pac="sudo pacman"
alias par="sudo pacman -Rsu"
alias paq="sudo pacman -Qe | grep "
alias pad="sudo pacman -Qe"
alias pai="sudo pacman -Qi"
alias grip="go-grip"
alias live="live-server --port=8000"

# KEY FILES
alias B="nvim ~/.bashrc"
alias C="nvim ~/.config"
alias S="nvim ~/Dotfiles/"
alias F="nvim ~/.config/foot/foot.ini"
alias G="nvim ~/.gitignore"
alias Gc="nvim ~/.gitconfig"
alias H="nvim ~/.config/hypr/hyprland.conf"
alias M="nvim ~/.config/mise/config.toml"
alias N="nvim ~/.config/nvim"
alias T="nvim ~/.tmux.conf"
alias Q="nvim ~/dotfiles/base/.config/qmk/keyboards/ferris/keymaps/main/"
alias R="nvim ~/Doc/notes/"
alias D="cd ~/Downloads"

function py() {
  if [ -d .venv ]; then
    uv run python "$@"
  else
    python "$@"
  fi
}

# ----------------
# GIT ALIASES
# ----------------
alias g="git"

## fugitive based alias
alias cc="git commit"
alias ca="git commit --amend"
alias rs="git rebase"
alias ri="git rebase -i"
alias rr="git rebase --continue"
alias ra="git rebase --abort"
alias coo="git checkout"
alias czz="git stash"
alias czm="git stash -m"
alias czl="git --no-pager stash list"
alias cza="git stash apply"
alias czp="git stash pop"

## common aliases
alias ga="git add" # (. or -p)
alias gr="git reset" # (--soft, --hard, default: --mixed). Only use mixed and hard
  alias grs="git reset --soft"
  alias grh="git reset --hard"
    alias grhp="git reset --hard HEAD@{1}"
  alias grv="git revert"  # fix
alias gu="git restore --staged" # unstage (put file name)
alias gw="git switch"
alias gi="git --no-pager log --graph --decorate --oneline" # info
  alias gia="git --no-pager log  --oneline --decorate --all --graph "
  alias gir='git --no-pager reflog'
alias gb="git --no-pager branch"
  alias gbd="git branch -d" # remove
alias gs="git status -s" # short condensed status
  alias gss="git status"
  alias gsh="git --no-pager show --stat --pretty=oneline"
alias gp="git push"
alias gy="git pull" # git 'yank'
alias gv="git --no-pager tag" # version
alias gm="git merge"
  alias gmt="git mergetool"
  alias gma="git merge --abort"
  alias gm1="git merge HEAD@{1}"
alias gc="git cherry-pick" # (. or -p)
alias gd="git difftool --tool=nvimdiff --word-diff --color --ignore-all-space --color-moved"
  alias gdd="git --no-pager diff --compact-summary --ignore-all-space"
  alias gdw="git difftool --tool=nvimdiff --staged --no-prompt --word-diff --color-moved --ignore-all-space"

alias w="git worktree"
alias wl="git worktree list"
alias wa="git worktree add"
alias wr="git worktree remove"
alias wp="git worktree prune"
function wg() {
  cd "$(git worktree list | awk '{print $1}' | fzf)" || return
}

alias ghl="gh auth login"
alias ghr="gh repo"
  alias ghrl="gh repo list"
  alias ghrw="gh repo view -w"
  alias ghrc="gh repo create"
alias ghp="gh pr"
alias ghpl="gh pr list"
alias ghpc="gh pr create"

# ----------------
# NAV ALIASES
# ----------------
# NOTE: hd = hopping. hopping depth 1, hopping to notes, hopping + edit in nvim
alias h='cd;cd "$(fd --type d --exclude Vault --exclude Media --exclude go/ | fzf)"'
alias hr='cd ~/Doc/notes && fd --type f --hidden --exclude .git \
  | fzf --preview "bat --style=numbers --color=always --line-range=1:200 {}" \
        --preview-window=right:70% \
        --bind "enter:execute(nvim {})+abort"'
alias hm='find "$HOME/Media/recordings" -type f -print0 | fzf --read0 --print0 --multi | xargs -0 -r xdg-open'
alias hd='find "$HOME/Downloads" -type f -print0 | fzf --read0 --print0 --multi | xargs -0 -r xdg-open'
alias hdp='find "$HOME/Downloads" -type f -iname "*.pdf" | fzf --multi | xargs -r xdg-open'
alias hdi='find "$HOME/Downloads" -type f \( \
  -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \
  -o -iname "*.gif" -o -iname "*.webp" -o -iname "*.avif" \
\) | fzf --multi | xargs -r xdg-open'

function he() {
  local selected_dir
  cd ~
  selected_dir=$(fd --type d --exclude go --exclude Media --exclude Downloads | fzf)
  if [[ -n "$selected_dir" ]]; then
cd "$selected_dir" || return 1
    nvim .
fi
}

# NNN: cd quit
function n () {
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

function hn() {
    local target
    # Uses fd to pick a directory, excluding specific paths
    target=$(fd --type d --exclude Vault --exclude Media --exclude go/ --base-directory ~ | fzf)

    if [[ -n "$target" ]]; then
        # Use nnn to open the selected directory
        n ~/"$target"
    fi
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
# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
#     . /usr/share/bash-completion/bash_completion
# source /usr/share/git/completion/git-completion.bash

# IMG RESPONSIVE (using node-pkg sharp-cli)
# Corrected AVIF Alias
alias webp=cwebp
alias avif=avifenc

alias avif_convert='for f in *.{webp,jpg,jpeg,png,JPG,PNG}; do \
  [ -e "$f" ] || continue; \
  name="${f%.*}"; \
  echo "Processing $f to AVIF..."; \
  sharp -i "$f" --effort 6 --metadata false  --smart-subsample -o "${name}-800w.avif"  -f avif -q 40 resize 800 & \
  sharp -i "$f" --effort 6 --metadata false  --smart-subsample -o "${name}-1200w.avif" -f avif -q 40 resize 1200 & \
  sharp -i "$f" --effort 6 --metadata false --smart-subsample -o "${name}-2200w.avif" -f avif -q 40 resize 2200 & \
  wait; \
done'

# Final WebP Alias
alias webp_convert='for f in *.{jpg,jpeg,png,JPG,PNG}; do \
  [ -e "$f" ] || continue; \
  name="${f%.*}"; \
  echo "Processing $f to WebP..."; \
  sharp -i "$f" -o "${name}-800w.webp"  -f webp -q 75 resize 800 & \
  sharp -i "$f" -o "${name}-1200w.webp" -f webp -q 70 resize 1200 & \
  sharp -i "$f" -o "${name}-2200w.webp" -f webp -q 70 resize 2200 & \
  wait; \
done'

alias tojpg='for f in *.{jpg,jpeg,png,JPG,PNG}; do [ -e "$f" ] || continue; name="${f%.*}"; echo "Creating fallback for $f..."; sharp -i "$f" -o "${name}-fallback.jpg" -f jpeg -q 75 resize 1600; done'

function fsubset {
    if [ $# -eq 0 ]; then
        echo "Usage: font <file1> <file2> ..."
        return 1
    fi

    for file in "$@"; do
        if [ -f "$file" ]; then
            local name="${file%.*}"
            echo "Subsetting: $file"
            pyftsubset "$file" \
                --unicodes="U+0020-007E" \
                --flavor=woff2 \
                --layout-features="kern, liga, clig, zero, tnum, case" \
                --output-file="${name}.subset.woff2"
        else
            echo "Error: $file not found."
        fi
    done
}

function fsubsetv {
    if [ $# -eq 0 ]; then
        echo "Usage: font-sub <file1.ttf> <file2.woff2> ..."
        return 1
    fi

    for file in "$@"; do
        if [ -f "$file" ]; then
            local name="${file%.*}"
            echo "------------------------------------------"
            echo "Processing: $file"

            # The "Pro" Subset Command
            # Includes Essential UI features: kern, liga, calt, case, zero, tnum
            # Variable font safety: --notdef-outline
            pyftsubset "$file" \
                --unicodes="U+0020-007E" \
                --flavor=woff2 \
                --layout-features="kern,liga,calt,case,zero,tnum" \
                --notdef-outline \
                --output-file="${name}.subset.woff2"

            if [ $? -eq 0 ]; then
                local old_size=$(du -h "$file" | cut -f1)
                local new_size=$(du -h "${name}.subset.woff2" | cut -f1)
                echo "Success! Size reduced from $old_size to $new_size"
            fi
        else
            echo "Error: $file not found."
        fi
    done
}

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

. "$HOME/.local/bin/env"
