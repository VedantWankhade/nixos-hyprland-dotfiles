# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # usb services
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable networking
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  networking.networkmanager.enable = true;

  # Set DNS servers
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Power management
  #services.power-profiles-daemon.enable = false;
  #powerManagement.enable = true;
  #services.tlp.enable = true;
  # taken from https://github.com/TechsupportOnHold/Batterylife/blob/main/laptop.nix
  # Better scheduling for CPU cycles - thanks System76!!!
  #services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Enable TLP (better than gnomes internal power manager)
  #services.tlp = {
   # enable = true;
   # settings = {
   #   CPU_BOOST_ON_AC = 1;
   #   CPU_BOOST_ON_BAT = 0;
   #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
   #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
   # };
  #};

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = true;

  # Enable powertop
  #powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  #services.thermald.enable = true;

  # Epic Gaming (its just steam and heroic)
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    extraPackages = [ pkgs.gamescope ];
  };
 
  # Fan control
 # programs.corectrl.enable = true;
 # programs.coolercontrol = {
 # enable = true;
 #   nvidiaSupport = true;
#};

  # lid close behaviour
  services.logind.lidSwitch = "ignore";

  # GPU
  hardware.opengl = {
    enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;
  
    dynamicBoost.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

    # nvidia optimus
    prime = {
      # sync mode
      #sync.enable = true;

      # OR offload mode
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Flatpak
  services.flatpak.enable = true;
  
  # Appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Virtualisation
  programs.dconf.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation = {
    # Containerisation
    containers.enable = true;
    # Docker
    #docker = {
    #  enable = true;
    #  enableOnBoot = true;
    #  rootless = {
    #    enable = true;
    #    setSocketVariable = true;
    #  };
    #  daemon.settings = {
    #    data-root = "/docker-data/data";
    #  };
    #};
    # Podman
    podman = {
      enable = true;
      #extraPackages = [ pkgs.podman-desktop pkgs.podman-compose ];
      defaultNetwork.settings.dns_enabled = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      #networkSocket = {
      # enable = true;
      # server = "ghostunnel";
      #};
    };

    # Virtual macines
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Tmux
  programs.tmux = {
   enable = true;
    extraConfigBeforePlugins = ''
      set -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ",xterm-kitty:RGB"
      set-option -g @log-file '/tmp/tmux.log'
      set -g mouse on
      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key j select-pane -D
      bind-key k select-pane -U
    '';
    plugins = [ pkgs.tmuxPlugins.catppuccin pkgs.tmuxPlugins.sensible ];
    extraConfig = ''
      # not working for some reason
      # set-option -g @catppuccin_flavour "frappe"
    '';
  };

  # npm configuration
  #environment.etc = {
  #  "npmrc" = {
  #    text = "prefix = \${HOME}/.npm-packages";
  #    mode = "0644";
  #    enable = true;
  #    user = "vedant"; # Replace with your actual username
  #    target = "/home/vedant/.npmrc"; # Replace with your actual username
  #  };
  #};

  services.gnome.gnome-keyring.enable = true;

  # snmp
  services.snmpd = {
    enable = true;
    openFirewall = true;
    configText = ''
      # Listen for connections from the local machine only
      agentAddress  tcp:127.0.0.1:161

      # Allow SNMPv1/v2c read access with a community string
      rocommunity public localhost

      # System information
      sysLocation  "MH, IND"
      sysContact   "vedantwankhade17@gmail.com"

      # Trap settings (optional)
      trapsink 127.0.0.1:162 public
    '';
  };

  # SSH
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Pantheon desktop
  # services.xserver.desktopManager.pantheon.enable = true;
  # programs.pantheon-tweaks.enable = true;
  # services.pantheon.apps.enable = true;
  # services.pantheon.contractor.enable = true;
  # services.xserver.displayManager.lightdm.greeters.pantheon.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # xdg
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde];
    xdgOpenUsePortal = true;
  };

  # for electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # qt theme
  qt.style = "breeze";
  qt.enable = true;
  qt.platformTheme = "kde";

  # Hyprland
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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
      # tmux = "tmux -u"; # use utf-8 for tmux (not needded as fixed by setting locale to en_US.UTF-8
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

    # for npm global package fix
    npm set prefix ~/.npm-packages
    export PATH=~/.npm-packages/bin:$PATH
    export NODE_PATH=~/.npm-packages/lib/node_modules

    # export GTK_THEME='Catppuccin-Mocha-Compact-Mauve-Dark'
    # fzf theme
    export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
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
    isNormalUser = true;
    useDefaultShell = true;
    description = "Vedant";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" "libvirtd" ];
    packages = with pkgs; [
      discord
      aseprite
      stremio
      podman-desktop
      kdePackages.kate
      slack
      google-chrome
      tree-sitter
      spotify
      spicetify-cli
      vscode
      beekeeper-studio
      insomnia
      zed-editor
      stow
      swww
      grimblast
      feh
      apple-cursor
      mpv
      lazygit
      fd
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

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    heroic
    poweralertd
    wineWowPackages.stable
    virt-manager
    virt-viewer
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
    gnumake
    protonvpn-gui
    net-snmp
    lxqt.lxqt-policykit
    tree
    wl-gammarelay-rs
    gcc
    nwg-look
    # libsForQt5.polkit-qt
    # lxqt.lxqt-policykit
    python3
    nodejs_20 # replace with bun in future
    go
    typescript
    jdk
    unzip
    fzf
    xfce.thunar
    btop
    zoxide
    kitty
    wofi
    # dunst
    swaynotificationcenter
    libnotify
    ripgrep
    networkmanagerapplet
    pavucontrol
    bat
    brightnessctl
    playerctl
    wl-clipboard
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
   enable = true;
   # enableSSHSupport = true;
 };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
