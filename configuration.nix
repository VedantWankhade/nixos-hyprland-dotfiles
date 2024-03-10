# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bleutooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # SSH
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Power management
  services.power-profiles-daemon.enable = false;
  powerManagement.enable = true;
  services.tlp.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };
  programs.waybar.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Shell
  users.defaultUserShell = pkgs.zsh; 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      lt = "tree";
      sysswitch = "sudo nixos-rebuild switch";
      sysboot = "sudo nixos-rebuild switch";
      sysedit = "sudo nvim /etc/nixos/configuration.nix";
      sysview = "bat /etc/nixos/configuration.nix";
    };
 
    # ohmyzsh
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "golang" "npm" ];
      theme = "bira";
    };
  };

  environment.shellInit = ''
    # Add zoxide initialization to zshrc
    if [ -x "$(command -v zoxide)" ]; then
      eval "$(zoxide init zsh)"
    fi
  '';
 
  # Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Fonts
  fonts = {
    packages = [ pkgs.font-awesome pkgs.maple-mono-NF ];
    fontconfig.enable = true;
    fontconfig.defaultFonts.monospace = [ "Maple Mono NF" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vedant = {
    useDefaultShell = true;
    isNormalUser = true;
    description = "Vedant";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      google-chrome
      spotify
      vscode
    ];
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        email = "vedantwankhade17@gmail.com";
	name = "VedantWankhade";
      };
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    tree
    fzf
    zoxide
    kitty
    wofi
    dunst
    libnotify
    swww
    ripgrep
    networkmanagerapplet
    feh
    pavucontrol
    bat
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
