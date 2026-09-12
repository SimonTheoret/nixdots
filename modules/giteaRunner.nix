{
  active ? false,
  name ? "GiteaRunner",
  token ? null,
  serverUrl ? "http://192.168.18.15:3000",

}:
{
  lib,
  ...
}:
{
  imports = [ ];
  config = lib.mkIf active {
    services.gitea-actions-runner.instances.${name} = {  
      enable = true;
      name = "${name}";
      token = "${token}";
      url = "${serverUrl}";
    };
  };
}
