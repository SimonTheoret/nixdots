{
  inputs,
  ...
}:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops.defaultSopsFile = ../secrets/secrets.yml;
  sops.defaultSopsFormat = "yaml";
  sops.secrets.wifi_name = { };
  sops.secrets.wifi_password = { };
}
