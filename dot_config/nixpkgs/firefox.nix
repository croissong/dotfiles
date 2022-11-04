{pkgs, ...}: let
  bookmarks = builtins.fromJSON (builtins.readFile "/home/croissong/Dotfiles/priv/buku-firefox-nix.json");
in {
  systemd.user.sessionVariables.MOZ_ENABLE_WAYLAND = 1;

  programs.firefox = {
    enable = true;

    profiles.dev-edition-default = {
      path = "p8klfsds.dev-edition-default";
      userChrome = ''
        #TabsToolbar { visibility: collapse; }
      '';

      bookmarks = bookmarks;

      settings = {
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.search.region" = "DE";

        # disable mouse pinch zoom
        "apz.allow_zooming" = false;
        "browser.gesture.pinch.in" = "";
        "browser.gesture.pinch.out" = "";
        # disable mouse wheel zoom
        "mousewheel.with_control.action" = 1;

        "browser.aboutConfig.showWarning" = false;
        "browser.startup.page" = 3;
        "browser.toolbars.bookmarks.visibility" = "never";
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "intl.accept_languages" = "en";

        # TODO: not sure if nix sets this automatically when 'userChrome' is confgured
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      search = {
        default = "Google";
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };

          "Github" = {
            urls = [{template = "https://github.com/search?q={searchTerms}&type=repositories";}];
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@gh"];
          };

          "Google".metaData.alias = "@g";

          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Amazon.de".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };
    };

    package = pkgs.wrapFirefox pkgs.firefox-devedition-bin-unwrapped {
      forceWayland = true;
      cfg = {
        enableTridactylNative = true;
      };

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
        RequestedLocales = ["en"];
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
          "jid1-xUfzOsOFlzSOXg@jetpack" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
          };
          "tridactyl.vim.betas.nonewtab@cmcaine.co.uk" = {
            installation_mode = "force_installed";
            install_url = "https://tridactyl.cmcaine.co.uk/betas/nonewtab/tridactyl_no_new_tab_beta-latest.xpi";
            install_sources = [
              "https://tridactyl.cmcaine.co.uk/betas/*"
            ];
          };
          "extension@tabliss.io" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tabliss/latest.xpi";
          };
          "spookfox@bitspook.in" = {
            installation_mode = "force_installed";
            install_url = "https://github.com/bitspook/spookfox/releases/download/v0.2.5/spookfox-firefox.xpi";
            install_sources = [
              "https://github.com/bitspook/spookfox/releases/download/*"
              "https://objects.githubusercontent.com/*"
            ];
          };
          "*" = {
            installation_mode = "blocked";
          };
        };
      };
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/47340#issuecomment-440645870
  home.file.".mozilla/native-messaging-hosts/tridactyl.json".source = "${pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts/tridactyl.json";

  # https://github.com/guibou/nixGL
  xdg.desktopEntries.firefox = {
    categories = ["Network" "WebBrowser"];
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
}