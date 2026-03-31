{
  config,
  pkgs,
  ...
}: {
  users.users = {
    wolfram = {
      isNormalUser = true;
      description = "wolfram";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIABGKgbuVdXgW6OlYcN0SJTnFKi13c0250FfAzxLJyGW your_email@example.com"
      ];
    };

    lambdajon = {
      isNormalUser = true;
      description = "wolfram";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHIWqwSw9U0/YrJza8SCOF0sT/khMMEbgmqwt7hy7TUV maykrasoft@kot.xp"
      ];
    };

    nigger = {
      isNormalUser = true;
      description = "nigga";
      extraGroups = [
        "neworkmanager"
        "shell"
      ];
    };
  };
}
