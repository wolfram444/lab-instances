{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;

    virtualHosts."funksiyachi.uz" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 80;
        }
      ];
      locations."/" = {
        return = "200 '<html><body>It works</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
}
