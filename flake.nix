{
  description = "Gundam94 Darwin system flake";
  # usage example
  # nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin#gundam94
  # darwin-rebuild switch --flake .config/nix-darwin#gundam94


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {
        nixpkgs.config.allowUnfree = true; # Allow unfree packages
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            # # # # # # # # # #
            # Terminal tools  # 
            pkgs.neovim # Text editor
            pkgs.tmux # Terminal multiplexer
            pkgs.mkalias # Used to create alias for macOS apps
            pkgs.bat # A cat clone with wings.
            pkgs.fd # A simple, fast and user-friendly alternative to 'find'
            pkgs.ripgrep # Recursively searches directories for a regex pattern
            pkgs.git # Distributed version control system
            pkgs.fzf # Command-line fuzzy finder
            pkgs.fish # User-friendly shell
            # # # # # # # # # #
            # UI Applications #
            pkgs.kitty # Terminal emulator
            pkgs.insomnia # REST client
            pkgs.vscode # Code editor
          ];

        homebrew = {
          enable = true;
          casks = [
            "notion" # A tool for notes, tasks, wikis, and databases
            "spotify" # Music streaming service
            "discord" # Chat for communities and friends
            "nikitabobko/tap/aerospace" # Tiling Window Manager
            "qbittorrent" # BitTorrent client
            "fisher" # A package manager for Fishell
          ];
          # onActivation.cleanup = "zap"; # Remove Homebrew packages not in the flake
          onActivation.autoUpdate = true; # Update Homebrew packages on activation
          onActivation.updagrade = true; # Upgrade Homebrew packages on activation
        };

        fonts.packages = [
          (pkgs.nerdfonts.override {
            fonts = [ "JetBrainsMono" ]; # Jetbrains Mono font
          })
        ];


        # Create alias for macOS apps when installing via Nix
        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        system.defaults = {
          dock.autoHide = true; # Automatically hide and show the Dock
          dock.persistent-apps = [
            # Applications in the Dock
            "{pkgs.kitty}/Applications/Kitty.app"
            "{pkgs.insomnia}/Applications/Insomnia.app"
            "{pkgs.vscode}/Applications/Visual Studio Code.app"
            "/System/Applications/Mail.app"
            "/System/Applications/Calendar.app"
            "/System/Applications/Reminders.app"
            "/System/Applications/Notes.app"
          ];
          finder.FXPreferredViewStyle = "clmv"; # Set Finder to column view
          finder.ShowPathbar = true; # Show path bar in Finder
          finder.ShowStatusBar = true; # Show status bar in Finder
          loginwindow.GuestEnabled = false; # Disable guest user
          NSGlobalDomain.AppleInterfaceStyle = "Dark"; # Set dark mode
          NSGlobalDomain.AppleICUForce24HourTime = true; # Set 24-hour time
          NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false; # Save to disk by default
          NSGlobalDomain.NSQuitAlwaysKeepsWindows = false; # Don't reopen windows on restart
          NSGlobalDOmain.KeyRepeat = 2; # Set key repeat rate
        };

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        # nixpkgs.hostPlatform = "x86_64-darwin";
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."gundam94" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true; # Enable Homebrew support
              enableRosetta = true; # Enable Rosetta 2 for x86_64 packages
              autoMigrate = true; # Automatically migrate Homebrew packages
              user = "rogerpoliver"; # Homebrew user
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."simple".pkgs;
    };
}
