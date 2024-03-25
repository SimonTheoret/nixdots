{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;
  syntaxHighlighting = { enable = true; };
  shellAliases = {
    cd = "z";
    gitg =
      "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
    gita = "git add";
    gitc = "git commit -m";
    gits = "git status";
    gitp = "git push";
    update = "sudo nixos-rebuild switch --flake ";
    rm = "trash";
    ect = "emacsclient -t";
  };
}
