{
  config,
  pkgs,
  ...
}: {
  services.minecraft-server = {
    package = pkgs.minecraftServers.vanilla-1-21;
    enable = true;

    eula = true;
    openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
    declarative = true;
    whitelist = {
      # This is a mapping of Minecraft usernames to to the players' UUIDs
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
    };
    jvmOpts = "-Xms2048M -Xmx2048M";
  };
}
