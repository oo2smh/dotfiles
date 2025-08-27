# Softwares
1. Hyprland (desktop window manager+)
2. Tmux
3. Browser
4. Terminal
5. Nvim
6. Qmk (kybd management)

# Hyprland
> [!Note]
> Core keymaps are baked into my kybd (qmk) as either a 1. combo 2. _quickfire layer key

```md
## Core Keys
bind = $MEH, t, togglespecialworkspace, terminal
bind = $MEH, r, togglespecialworkspace, reference
bind = SUPER, tab, exec, ~/.config/hypr/toggle_monitors.sh
bind = SUPER, backspace, cyclenext, bringactivetotop
bind = SUPER, space, fullscreen, 1 # Maximize
bind = SUPER, period, closewindow, activewindow

## Extra Keys
bind = $SUPERMAN, q, exec, hyprctl dispatch exit
bind = $SUPERMAN, h, movetoworkspace, 1
bind = $SUPERMAN, t, movetoworkspace, 2
bind = $SUPERMAN, n, movetoworkspace, special:reference
bind = $SUPERMAN, s, movetoworkspace, special:terminal

bind = SUPER, l, workspace, 1
bind = SUPER, d, workspace, 2

bind = SUPER, t, exec, foot # terminal
bind = SUPER, b, exec, zen-browser # browser

bind = SUPER, h, resizeactive, -10% 0
bind = SUPER, t, resizeactive, 0 10%
bind = SUPER, n, resizeactive, 0 -10%
bind = SUPER, s, resizeactive, 10% 0

### immediate capture
bind = $CAL, v, exec, cliphist list | head -n 1 | cliphist delete; cliphist list | head -n 1 | cliphist decode | wl-copy; notify-send "Clipboard popped and updated"
bind = $CAL, b, exec, pkill waybar || waybar # bar
bind = $CAL, n, exec, hyprshade toggle blue-light-filter # nightshade
bind = $CAL, space, exec, hyprshot -m region -o /tmp/screenshots --freeze
bind = $CAL, tab, exec, hyprshot -m region --freeze -o ~/Media/screenshots/

### views
Bind = $ZX_VIEW, s, exec, pkill pavucontrol || pavucontrol # sound
bind = $ZX_VIEW, m, exec, pkill rofi || cliphist list | rofi -show calc -modi calc -no-show-match -no-sort -terse | tr -d '\n' | wl-copy
bind = $ZX_VIEW, h, exec, pkill rofi || cliphist list | rofi -dmenu +display-columns 2 | cliphist decode | wl-copy
bind = $ZX_VIEW, space, exec, pkill rofi || rofimoji -a clipboard copy print -s light
bind = $ZX_VIEW, tab, exec, pkill rofi || rofi -show drun | xargs hyprctl dispatch exec
```

# Tmux
> [!Warning]
>  Compatability with wayland (clipboard, ctrl bspc keybind)
>  - use `env` in the terminal while in a tmux session to see if the variables were passed through.

> [!Tip]
> Try to only use 2 panes and 2 windows per session so that you can cycle through with a single keybind. I also included a visual cue (color change) to let me know when I am in fullscreen.

```yaml
set -g default-shell "/bin/bash"
set-option -g set-clipbobrd on # !allows clipboard access in nvim
set -g mouse on
set -g base-index 1
set -g renumber-windows on
s et-option -g pane-active-border-style bg=orange # better active pane indicator
set-option -g focus-events on
set -g status-style 'bg=#{?window_zoomed_flag,yellow,default},fg=#{?window_zoomed_flag,black,default}'
set-option -g status-position top

set-environment -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"
set-environment -g WAYLAND_DISPLAY "$WAYLAND_DISPLAY"
set-environment -g XDG_RUNTIME_DIR "$XDG_RUNTIME_DIR"

bind r source-file ~/.tmux.conf \; display-message "tmux config reloaded"
bind-key -n C-h send-keys C-w #ctrl bspc.. working
bind -n M-Tab last-pane
bind -n M-Space resize-pane -Z
bind -n C-Tab next-window

bind -n M-Tab run-shell '
if [ "$(tmux list-panes | wc -l)" -eq 1 ]; then
    # Only one pane, create a new one (split vertically here, change as you like)
    tmux split-window
else
    # More than one pane exists
    if [ "$(tmux display-message -p "#{window_zoomed_flag}")" = "1" ]; then
        tmux last-pane \; resize-pane -Z
    else
        tmux last-pane
    fi
fi
'

set-hook -g client-attached 'run-shell "~/.tmux/plugins/tmux-resurrect/scripts/restore.sh"'

set -g @tpm_plugins "tmux-plugins/tpm \
  tmux-plugins/tmux-resurrect"

run -b "~/.tmux/plugins/tpm/tpm"
```

# Browser
- vimium c
- video speed controller

```md
- <A-.>   : close tab
- <A-tab> : change workspace
- <A-#>   : select # tab
-
```


```yaml [vimium c]
unmapAll
map h LinkHints.activate
map H LinkHints.activateOpenInNewTab
map gg scrollToTop
map G scrollToBottom
map <a-.> removeTab
map <a-t> createTab
map <a-g> moveTabLeft
map <a-w> moveTabRight
```

```yaml [video speed]
- . slower
- , faster
```

# Terminal
> [!Tip]
> My aliases are 2 kinds: actions and jumps. Action aliases are <= 3 chars and all lowercase. Jump aliases will go to a specific repo and is capitalized.
- For navigation, use `h`(hop), or `n`(navigate). Hopping involves fuzzy finding. Navigating uses `nnn` and involves the traditional tree-like file manager system.
- Other than aliases, my `.bashrc` is used for env variable management so that other programs can play nice (ie: `nnn`)

# Nvim
> [!Note] Navigation, Views, Visual Cues, Efficient Operations
## Navigation
### Buffer transfer: h-based
  - `h` to fuzzy-hop to a file.
    - `ht`: traversed (old) files
    - `hn`: new hunks (useful to quickly glance at changed files)
    - `hd`: diagnostics
    - `hs`: string search
  - `n` to navigate a file structure
  - `superargs` for fast warping to buffers
#### Superargs
- core (1-3)
  1. home: hotfix, holster file (put file that has issues)
  2. task: current task file
  3. notes: readme file
  4. main: main engine (big picture)
  5. git: prev version of file..to compare optional..renamed with _ prefix
- bot (4-6) optional
  - 2 different setup
    - `more-info` section for more complex interlinked projects
      - 3 modules that are connected to the main task file
    - Queue for simpler projects
      - can be used as a waiting list to work on after core task is done
    - Task chunk 2
      - can be used as the same setup for task 1 if you want to jump between 2 tasks

### In-buffer
> [!Tip]
> `/?` are superior form of movement because you can move diagonally. The other movements require you to move in only 1 axis (x or y).

#### Block moves
  - Standardized Local Marks
  - If you are multitasking, the left marks correspond to 1 task and the right to that specific task. It is a mirror of each other.
    - use `r/R` for both sides (recent). Use it when you are making any big jumps
    1. Base
      - `t`/`e`: task/event
      - `h`: hotfix
      - `d`/`o`: definition of bigger structure/object: fn/class/interface
      - `n`/`i`: notes/info task (connected task)
      - `m`/`,`: main, engine
      - `y`/`p`: yank/paste, aka examples
  - Historical jumps (<C-i>, <C-o>)
  - Search jumps (/?*)
  - Scrolls (these don't add to the jumplist)
  - Relative jumps

#### Inline moves
  - use search jumps (/?) here
  - `ft` jumps
  - spam ctrl left and right with repeat keys
  - if the movement requires more than 3 keystrokes, jump, otherwise spam arrow keys

## Views
- Views offer additonal info or are alternative forms of travel
- Based off of `mini.pick`. Leader + `uqmcgl`
  - questions (docs)
  - undos (changelist<)
  - clipboard
  - giti
  - marks
  - lsp

## Visual Cues
- Many nvim plugins are to provide visual cues
- [statusline, tabline, indentscope, diff]

## Efficient Operations
> [!Caution]
> [!Note]
> Try to stay in insert-mode or insert-normal mode using `ctrl-o` to stay in flow. Some operations with `insert-normal` mode breaks my set keybindings, so learn and work with only a few keybindings.

### Insert Mode Sequences
> [!Note] Perform 1 operation and move back to insert mode
- <C-o>p/P: paste
- <C-u>: delete from cursor to the start of text

 ## Registers Standardized
- only going to choose a set of letters based on the keys' proximity to `y`, `p`, `d` which are the operators that are used which registers
- Like marks, you are juggling between at most 2 tasks, the right and the left side.
- `h`/`a`: holder temporary and ad-hoc
- `l`/`u`: long-term, universal registers (these are more common uses)
- other uses, save them and fuzzy search for them

# Qmk

