 {
  accounts.hotmail = {
    address = "simonteoret@hotmail.com";
    primary = true;
    flavor = "outlook.office365.com"; # this makes it easy
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    realName = "Simon Théorêt";
    passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ~/.mymail.gpg";
    userName = "simonteoret@hotmail.com";
  };
}
