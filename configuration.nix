{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/power.nix
    ./modules/files.nix
    ./modules/engineering.nix
];

  # Boot
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # System
  networking.hostName = "Gunter_Nix";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Automatic TTY login.
  services.getty.autologinUser = "Gunter";

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = {};

  # Audio
  services.pulseaudio.enable = false;

  # User
  users.users.Gunter = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      tree
    ];
  };

  programs.zsh.enable = true;

  # Keep this temporarily if you want Firefox as a fallback.
  programs.firefox.enable = true;

  # System-wide tools/apps
  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    git
    hyprpaper
    zed-editor
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
