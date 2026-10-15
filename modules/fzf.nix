{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions = [
      "--height=45%"
      "--layout=reverse"
      "--border=sharp"
      "--info=inline"
      "--prompt=  "
      "--pointer=▌"
      "--marker=✓"

      "--color=bg:#0f1018,bg+:#202337,fg:#f4f1ff,fg+:#f4f1ff,hl:#f29ac3,hl+:#f29ac3,prompt:#c6a0f6,pointer:#f29ac3,marker:#c6a0f6,spinner:#7dcfe3,info:#878b9f,border:#8aadf4"
    ];

    # CTRL+T
    fileWidget = {
      command =
        "${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git .";

      options = [
        "--preview '${pkgs.bat}/bin/bat --color=always --style=numbers --line-range=:500 {}'"
        "--preview-window=right:55%:wrap"
      ];
    };

    # ALT+C
    changeDirWidget = {
      command =
        "${pkgs.fd}/bin/fd --type d --hidden --follow --exclude .git .";
    };

    # CTRL+R
    historyWidget = {
      options = [
        "--sort"
        "--exact"
      ];
    };
  };

  home.packages = with pkgs; [
    fd
    ripgrep
    bat
  ];
}
