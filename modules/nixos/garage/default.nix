{
  config,
  pkgs,
  ...
}: {
  services.garage = {
    enable = true;
    package = pkgs.garage;

    settings = {
      replication_mode = "2";
      data_dir = "/var/lib/garage/data";
      metadata_dir = "/var/lib/garage/meta";

      rpc_bind_addr = "0.0.0.0:3901";
      rpc_secret = "b8ed42b061bee4500b4fbe783ef87b2be78a8e58fdb6318278c9ee492c408c27";

      s3_api = {
        s3_region = "garage";
        bind_addr = "0.0.0.0:3900";
      };
    };
  };
}
