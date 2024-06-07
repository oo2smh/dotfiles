#OTHER
alias ls="ls --color=auto"

# ALIASES
# Navigation
alias Zshrc="nvim ~/.zshrc"
alias Config="nvim ~/.config"
alias Nvim="nvim ~/.config/nvim"
alias Zellij="nvim ~/.config/zellij"
alias Hypr="nvim ~/.config/hypr/hyprland.conf"
alias Foot="nvim ~/.config/foot/foot.ini"
alias Star="nvim ~/.config/starship.toml"
alias Tofi="nvim ~/.config/tofi/config.ini"
alias Source="source ~/.zshrc"
alias pac="sudo pacman"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log"


# INITALIZE
eval "$(starship init zsh)"
eval "$(zellij setup --generate-auto-start zsh) "

# SCRIPT PATH
export PATH=/home/hamin/.local/bin:$PATH

# NNN Setup
export EDITOR='nvim'

# NOTES
# <C-d> Exits the current session. This exits zellij if not in a nvim session.
# If in nvim, this should be pg down. Be careful with this
