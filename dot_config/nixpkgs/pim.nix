{
  pkgs,
  config,
  ...
}: let
  secrets = import ./secrets.nix;
in {
  nixpkgs.overlays = [
    (self: super: {
      isync = super.isync.override {withCyrusSaslXoauth2 = true;};
    })
  ];

  programs = {
    mbsync = {
      enable = true;
    };

    vdirsyncer = {
      enable = true;
    };

    himalaya = {
      enable = true;
      package = pkgs.himalaya.override {withNotmuchBackend = true;};
    };

    notmuch = {
      enable = true;
    };
  };

  services = {
    mbsync = {
      enable = true;
      postExec = "${pkgs.notmuch}/bin/notmuch new";
      frequency = "0/1:00:00";
    };
  };

  accounts = {
    email = {
      maildirBasePath = ".local/share/mail";

      accounts = {
        datawerk = {
          address = secrets.mail.datawerk.username;
          primary = true;
          flavor = "outlook.office365.com";
          realName = "Jan Möller";
          passwordCommand = "mailctl access ${secrets.mail.datawerk.username}";
          gpg = {
            signByDefault = true;
            key = "jan.moeller0@gmail.com";
          };

          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            extraConfig.account = {
              AuthMechs = "XOAUTH2";
            };

            patterns = ["INBOX"];
          };

          notmuch = {
            enable = true;
          };

          himalaya = {
            enable = true;
            settings = {
            };
          };
        };
      };
    };

    calendar = {
      basePath = ".local/share/calendars";
      accounts = {
        wrk_dw = {
          name = "wrk_dw";
          local = {
            fileExt = ".ics";
            type = "filesystem";
          };

          remote = {
            url = "http://localhost:1080/users/${secrets.mail.datawerk.username}/calendar/";
            type = "caldav";
            userName = "${secrets.mail.datawerk.username}";
            passwordCommand = ["echo" "${secrets.mail.datawerk.password}"];
          };

          vdirsyncer = {
            enable = true;
            collections = ["calendar"];
            itemTypes = ["VEVENT"];
            timeRange = {
              start = "datetime.now() - timedelta(days=7)";
              end = "datetime.now() + timedelta(days=30)";
            };
          };
        };
        # birthdays = {
        #   name = "birthdays";
        #   primary = true;
        #   local = {
        #     type = "filesystem";
        #     path = "~/.local/share/contacts";
        #     fileExt = ".vcf";
        #   };
        #   khal = {
        #     enable = true;
        #     type = "calendar";
        #   };
        # };
      };
    };

    contact = {
      basePath = "~/.local/share/contacts";
      accounts = {
        prv = {
          name = "prv";
          local = {
            type = "filesystem";
            fileExt = ".vcf";
          };
          # TODO: when protonmail supports carddav
          # remote = {
          # };

          # vdirsyncer = {
          #   enable = true;
          # };

          # khal = {
          #   enable = true;
          #   readOnly = true;
          # };
        };
      };
    };
  };

  systemd.user = {
    services = {
      calsync = {
        Unit = {
          Description = "calsync";
          OnFailure = "failure-notify@%n";
        };

        Service = {
          Type = "oneshot";
          ExecStart = "%h/.local/bin/calsync";
        };
      };

      "failure-notify@" = {
        Unit = {
          Description = "notify on failure";
        };

        Service = {
          Type = "simple";
          ExecStart = "/usr/bin/notify-send --urgency=critical --expire-time=60000 '%i failed'";
        };
      };
    };

    timers = {
      calsync = {
        Unit = {
          Description = "regular calsync";
          After = "network-online.target";
        };

        Timer = {
          Unit = "calsync.service";
          OnCalendar = "0/2:00:00";
          AccuracySec = "10min";
        };

        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };
}
