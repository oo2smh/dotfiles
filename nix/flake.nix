{
  description = "My user packages";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    packages.${system}.default = pkgs.buildEnv {
      name = "my_packages";
      paths =  [
        # ESSENTIALS
        pkgs.hyprland
        pkgs.foot # lightweight terminal
        pkgs.tmux # multiplexer
        pkgs.neovim
        pkgs.xournalpp # whiteboard
        pkgs.tesseract # img to text (ocr)
        pkgs.nnn
        pkgs.qmk
        pkgs.cliphist # wayland clipboard
        pkgs.feh # img viewer
        pkgs.hyprshot
        pkgs.hyprshade # eye care
        pkgs.hack-font # font
        pkgs.rofi # view launcher/selector (apps, emojis, etc)
        pkgs.mpv # vid viewer
        pkgs.opentabletdriver
        # zen (not available in nixpkgs)

        pkgs.waybar
        pkgs.obs-studio # video recorder
        pkgs.rofi-calc # calculator
        pkgs.rofimoji #emojis
        pkgs.dunst # notification
        pkgs.noto-fonts-color-emoji # more emoji support

        # CLI TERMINAL TOOLS
        pkgs.git
        pkgs.starship # prettier terminal
        pkgs.trash-cli
        pkgs.bat # better cat (with sytx highlighting)
        pkgs.fd # better cli find
        pkgs.fzf # fuzzy find
        pkgs.ripgrep # search text using regex patterns
        pkgs.unzip
        pkgs.bash-completion
        pkgs.github-cli
        pkgs.go-grip # markdown viewer
        pkgs.pdfmixtool
        pkgs.direnv # env automator

        # SYS MANAGER
        pkgs.pipewire # sound, allows screensharing in obs
        pkgs.polkit # convenience gatekeeper. low-privilege can do root stuff without having to type sudo passoword

        # LANGUAGE SPECIFIC
        pkgs.uv # python pkg manager. faster pip
        pkgs.go
      ];
    };
  };
}


