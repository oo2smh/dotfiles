# Softwares
1. [Hyprland](./hypr/hyprland.conf)
2. [Tmux](./.tmux.conf)
3. Browser (zen)
4. [Terminal (bash)](./.bashrc)
5. [Nvim](./nvim/lua/)
6. [Qmk](./qmk/keymap.c)

> [!Tip] Use `gf` to open the files when viewing README in neovim

# Hyprland
> [!Note]
> Core keymaps are baked into my kybd (qmk) as either a 1. combo 2. quickfire layer key

Special consideration was taken to make the keybinds aligned with a Windows computer. This is because my keyboard has combos that provide shortcuts to many of these keybinds and it would be nice to have my keyboard have continuity on a Windows system.

# Tmux
> [!Warning]
>  Compatability with wayland (clipboard, ctrl bspc keybind)
>  - use `env` in the terminal while in a tmux session to see if the variables were passed through.

> [!Tip]
> Try to only use 2 panes and 2 windows per session so that you can cycle through with a single keybind. I also included a visual cue (color change) to let me know when I am in fullscreen.


I don't use most of the features. Resize with the mouse and use the prefix with other commands to create new panes, restore/save sessions.

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
map h LinkHints.activate
map H LinkHints.activateOpenInNewTab
map gg scrollToTop
map G scrollToBottom
map <a-g> moveTabLeft
map <a-w> moveTabRight
map ( Vomnibar.activateBookmarks
map <a-p> togglePinTab
```

```yaml [video speed]
- . slower
- , faster
```

# Terminal
> [!Tip]
> My aliases are 2 kinds: actions and jumps. Action aliases are 1-4 chars and all lowercase. Jump aliases will go to a specific repo and is capitalized.

- For navigation, use `h`(hop) aka fuzzy finding, or `n`(navigate), moving through a tree-like structure. Navigating uses `nnn` and involves the traditional tree-like file manager system.
- Other than aliases, my `.bashrc` is used for env variable management so that other programs can play nice (ie: `nnn`)
- My aliases can be divided mainly into sys and git

# Nvim
> [!Note] Navigation, Visual Cues, Efficient Operations
## **NAVIGATION*
### Buffer transfer
#### Hopper
  - `h` to hop open a view
    - `ht`: traversed top cwd files
    - `hn`: navigate (nnn)
    - `hd`: buffer diagnostics
    - `hp`: project wide diagnostics
    - `hs`: string search
    - `ho`: open buffers
    - `hm`: local marks
    - `hM`: global marks
    - `hh`: help manuals
    - `hf`: fix me highights
    - `hk`: keybinds
    - `hz`: zone highlights
    - `ha`: adjustments (git)
  - `hi`: implements a setting ((a)rgslist, (h)ighlights, (s)ession)

#### Argslist
- core (1-3)
  1. 🐧 hub: the biggest file
  2. 🎯 target: current file to tackle
  3. 🐶 neighbor: support for target (test, reference)
  4. 🔥 magma: hotfix or urgent, things to purge
  5. 🪱 ground: either stable (vars) or granualar details
  6. 🌊 water: wandering. prone to change. experimentation

#### Global Marks, Persistent Files
- global marks (aeiyou)
  - consists of vowels only
  - used for extra references as needed
- Persistent Files
  - <space>(letter)
  - README, _temp, _notes
  - README is for the public
  - _temp is for todo and temp (clipboard history)
  - notes are for me. Takeaways. It can also be used to organize a project (ie: list of vars and functions)

### In-buffer
> [!Tip]
> `/?` are superior form of movement because you can move diagonally. The other movements require you to move in only 1 axis (x or y). You can also use these with operators such as d/<search_term> or c?<search_term>

#### Block moves
  - Standardized Local Marks
  - If you are multitasking, the left marks correspond to 1 task and the right to that specific task. It is a mirror of each other.
    - use `r/R` for both sides (recent). Use it when you are making any big jumps
    1. Base (mirors the argslist)
      - 🐧 hub: biggest engine of the buffer
      - 🎯 temp/target: temp mark. Use often
      - 🐶 neighbor: ref point for temp/target
      - 🔥 magma: fix required
      - 🪱 ground: granualar details to target
      - 🌊 water: wandering. things to explore later
  - Historical jumps (<C-i>, <C-o>)
  - Search jumps (/?*)
  - Scrolls (these don't add to the jumplist)
  - Relative jumps (using numbers)
  - Highlight jumps (using vim-highlighter plugin)

#### Inline moves
  - use search jumps (/?) here
  - `ft` jumps
  - spam ctrl left and right with repeat keys
  - if the movement requires more than 3 keystrokes, jump, otherwise spam arrow keys

## *VISUAL CUES*
- Many nvim plugins are to provide visual cues
- [statusline, tabline, indentscope, diff]

 ## *REGISTERS STANDARDIZED*
- Use sys-clipboard, (")clipboard, yank(0) clipboard, and the (a) clipboard

# QMK
> This probably had the most complex config out of all the other items. Some thought went into placing keys in ergonomic positions as well as thinking about the keys next to each key to maximize rolls.
