{pkgs, config, ...}: {
  systemd.user = {
    services = {
      backup = {
        Unit = {
          Description = "autorestic backup";
          OnFailure = "failure-notify@%n";
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.autorestic}/bin/autorestic --ci cron";
        };
      };
    };

    timers = {
      backup = {
        Unit = {
          Description = "autorestic backup";
        };

        Timer = {
          Unit = "backup.service";
          OnCalendar = "0/2:00:00";
          AccuracySec = "10min";
        };

        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };

    # "rclone-gitwatch" = {
    #   Unit = {
    #     Description = "Watch file or directory and git commit all changes";
    #     After = ["rclone-mount.service"];
    #   };
    #   Install.WantedBy = ["multi-user.target"];
    #   Service = {
    #     ExecStart = ''
    #       gitwatch
    #     '';
    #     ExecStop="/bin/true";
    #     Type = "notify";
    #     Restart = "always";
    #     RestartSec = "10s";
    #   };
  # };
}
