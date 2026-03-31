{
  config,
  pkgs,
  ...
}: {
  services.minecraft-server = {
    package = pkgs.minecraftServers.vanilla-1-21;
    enable = true;

    eula = true;
    openFirewall = true;
    declarative = true;
    whitelist = {
      username1 = "3e220001-9544-48bb-8fd0-ca7139727207";
      username2 = "75b46c6c-bdbd-42ce-818e-43e94af0c043";
    };

    serverProperties = {
      server-port = 25565;
      difficulty = 3;
      gamemode = 1;
      max-players = 10;
      motd = "NixOS Minecraft server!";
      white-list = true;
      allow-cheats = true;
      view-distance = 15;
    };
    jvmOpts = "-Xms2048M -Xmx8G";
  };
}
