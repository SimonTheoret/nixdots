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
    passwordCommand = "cat ~/.mymail";
    userName = "simonteoret@hotmail.com";
  };
}
