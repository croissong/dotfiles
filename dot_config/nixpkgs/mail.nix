{pkgs, ...}: let
  secrets = import ./secrets.nix;
in {
  services.imapnotify.enable = true;

  programs.mbsync = {
    enable = true;
    package = pkgs.isync-oauth2;
  };
  accounts.email = {
    maildirBasePath = ".local/share/mail";

    accounts = {
      iogroup = {
        address = secrets.mail.datawerk.username;
        primary = true;
        flavor = "outlook.office365.com";
        passwordCommand = "mailctl access ${secrets.mail.datawerk.username}";

        folders = {
          inbox = "INBOX";
          # TODO: drafts,sent,trash
        };

        imap = {
          port = 993;
          host = "outlook.office365.com";
          tls.enable = true;
        };
        imapnotify = {
          enable = true;
          boxes = ["INBOX" "ops"];
          onNotify = "/usr/bin/mailsync jm@iogroup.org"; # TODO
          extraConfig = {
            xoauth2 = true;
          };
        };

        maildir = {
          # TODO: remove this and switch maildir references to default: .local/share/mail/iogroup/
          path = "jm@iogroup.org";
        };

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          extraConfig.account = {
            AuthMechs = "XOAUTH2";
          };
        };
      };
    };
  };
}
