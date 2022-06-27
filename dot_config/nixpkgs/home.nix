{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  systemd.user.sessionVariables = {

    # used by: slack
    NIXOS_OZONE_WL = 1;
  };

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/termdown/default.nix
  nixpkgs.overlays = [
    (self: super: {
      termdown = super.termdown.overrideAttrs (prev: rec {
        version = "1.18.0";
        src = super.fetchFromGitHub {
          rev = version;
          sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
          repo = "termdown";
          owner = "trehn";
        };
      });
    })
  ];


  services.wlsunset = {
    enable = true;
    latitude = "51.3";
    longitude = "9.5";
    temperature.night = 2500;
  };

  home = {
    stateVersion = "21.11";
    homeDirectory = "/home/croissong";
    username = "croissong";

    packages = with pkgs; [
      argocd # Declarative continuous deployment for Kubernetes
      calibre # Ebook management application
      chezmoi # Manage your dotfiles across multiple machines
      i3status-rust # Resourcefriendly and feature-rich replacement for i3status, written in pure Rust

      nixpkgs-fmt
      termdown # Countdown timer and stopwatch in your terminal
      rust-analyzer # Experimental Rust compiler front-end for IDEs
      slack # Slack Desktop for Linux, using the system Electron package
      syncthing # Open Source Continuous Replication / Cluster Synchronization Thing
      wl-color-picker # A wayland color picker that also works on wlroots
      wlsunset # Day/night gamma adjustments for Wayland compositors
      xplr # A hackable, minimal, fast TUI file explorer

    ];
  };

  imports = [
    ./packages.nix
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--enable-webrtc-pipewire-capturer"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  programs.firefox = {
    enable = true;

    profiles.dev-edition-default = {
      path = "p8klfsds.dev-edition-default";
      userChrome = ''
        #TabsToolbar { visibility: collapse; }
      '';
    };

    package = pkgs.wrapFirefox pkgs.firefox-devedition-bin-unwrapped {
      forceWayland = true;
      extraPolicies = {
        # https://github.com/mozilla/policy-templates/blob/master/README.md

        DefaultDownloadDirectory = "/tmp/";
        DisableAppUpdate = true;
        DisableFirefoxStudies = true;
        DisableFirefoxScreenshots = true;
        DisablePocket = true;
        DontCheckDefaultBrowser = true;
        PasswordManagerEnabled = false;
        PictureInPicture = {
          Enabled = false;
          Locked = true;
        };
        PromptForDownloadLocation = true;
        RequestedLocales = [ "en" ];
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = true;
          UrlbarInterventions = true;
          SkipOnboarding = true;
        };

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
          "@markdown_to_jira" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/markdown-to-jira/latest.xpi";
          };
          "extension@tabliss.io" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tabliss/latest.xpi";
          };
          "jid1-xUfzOsOFlzSOXg@jetpack" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
          };
          "simple-tab-groups@drive4ik" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-tab-groups/latest.xpi";
          };
          "*" = {
            installation_mode = "blocked";
          };
        };
      };

      extraPrefs = ''
        // Show more ssl cert infos
        lockPref("browser.aboutConfig.showWarning", false);
        lockPref("browser.startup.page", 3);
        lockPref("browser.toolbars.bookmarks.visibility", "never");
        lockPref("extensions.htmlaboutaddons.recommendations.enabled", false);
        lockPref("intl.accept_languages", "en");
        lockPref("mousewheel.with_control.action", 1);
        // lockPref("security.ssl.enable_ocsp_stapling", true);
        lockPref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

        // https://wiki.archlinux.org/title/firefox#Wayland
        // disabled: causes ugly scrolling
        // lockPref("gfx.webrender.compositor.force-enabled", false);


        // disable mouse pinch zoom
        lockPref("apz.allow_zooming", false);
        lockPref("browser.gesture.pinch.in", "");
        lockPref("browser.gesture.pinch.out", "");
      '';
    };
  };


  # https://github.com/guibou/nixGL
  xdg.desktopEntries.firefox = {
    categories = [ "Network" "WebBrowser" ];
    exec = "nixGL firefox %U";
    genericName = "Web Browser";
    icon = "firefox";
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/ftp"
    ];
    name = "Firefox (Wayland)";
    type = "Application";
  };

  systemd.user.sessionVariables.MOZ_ENABLE_WAYLAND = 1;



}
