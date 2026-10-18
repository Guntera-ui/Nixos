{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/files.nix
      ./modules/asus-keyboard.nix
      ./modules/engineering.nix
      ./modules/hyprland-session.nix
      ./modules/tty-login.nix
      ./modules/steam.nix
      ./modules/battery-protection.nix
];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Gunter4070"; # Define your hostname.

  networking.networkmanager.enable = true;
  # ASUS laptop hardware controls
  services.asusd.enable = true;

  time.timeZone = "Europe/Berlin";

  users.users.Gunter = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ];
   };
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  security.pam.services.hyprlock = {};

  programs.zsh.enable = true;
  users.users.Gunter.shell = pkgs.zsh;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
];
  services.pulseaudio.enable = false;


  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    kitty
    hyprpaper
    zed-editor
    tree
    gh

];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"


];
 console.keyMap = "us";
 services.xserver.xkb.layout = "us";
 hardware.graphics = {
 enable = true;
 enable32Bit = true;

};

 nixpkgs.config.allowUnfree = true;

 services.xserver.videoDrivers = [
   "amdgpu"
   "nvidia"
];
 boot.blacklistedKernelModules = [
   "nouveau"
];

hardware.nvidia = {
 modesetting.enable = true;
 open = true;
 powerManagement.enable = true;
 nvidiaSettings = true;
 prime = {
  offload = {
    enable = true;
    enableOffloadCmd = true;

};
    amdgpuBusId = "PCI:102@0:0:0";
    nvidiaBusId = "PCI:101@0:0:0";
};

};

  system.stateVersion = "26.05"; # Did you read the comment?

}
