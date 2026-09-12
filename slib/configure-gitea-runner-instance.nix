{
  name,
  token ? null,
  serverUrl ? "http://192.168.18.15:3000",
}:
{
  services.gitea-action-runner.instances.${name}.enable = true;
  services.gitea-action-runner.instances.name.name = "${name}";
  services.gitea-action-runner.instances.token.token = "${token}";
  services.gitea-action-runner.instances.url = "${serverUrl}";

}
