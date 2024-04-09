{ lib }: {
  accounts.hotmail = {
    address = "simonteoret@hotmail.com";
    primary = true;
    flavor = "outlook.office365.com";
    # gpg = {
    #   key = "F9119EC8FCC56192B5CF53A0BF4F64254BD8C8B5";
    #   signByDefault = true;
    # };
    imap.host = "outlook.office365.com";
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    realName = "Simon Théorêt";
    passwordCommand = "cat ~/.mymail";
    smtp = { host = lib.mkForce "smtp-mail.outlook.com"; };
    userName = "simonteoret@hotmail.com";
  };
}
