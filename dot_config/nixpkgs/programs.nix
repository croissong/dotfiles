{pkgs, ...}: let
in {
  programs = {
    go = {
      enable = true;
    };

    java = {
      enable = true;
    };
  };

  programs.firefox = {
    enable = true;

    profiles.dev-edition-default = {
      path = "p8klfsds.dev-edition-default";
      userChrome = ''
        #TabsToolbar { visibility: collapse; }
      '';

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
