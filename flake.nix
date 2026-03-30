{
  description = "Configurations for various instances for educational purposes";

  # Extra nix configurations to inject to flake scheme
  # => use if something doesn't work out of box or when despaired...
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [ "https://cache.xinux.uz/" ];
    extra-trusted-public-keys = [ "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" ];
    allow-import-from-derivation = true;
  };
  inputs = {
    nixpkgs.url = "github:xinux-org/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:xinux-org/nixpkgs/nixos-unstable";

    # Pre commit hooks for git
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    relago-support.url = "github:xinux-org/relago-support";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        formatter = pkgs.nixfmt;
        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    )
    // {
      lib = nixpkgs.lib;
      # nixosModules = import ./modules/nixos;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            # > Our main nixos configuration file <
            ./hosts/sholcha/configuration.nix
          ];
        };
      };
    };
}
