# {
#   description = "Configurations for various instances for educational purposes";
#   # Extra nix configurations to inject to flake scheme
#   # => use if something doesn't work out of box or when despaired...
#   nixConfig = {
#     experimental-features = [
#       "nix-command"
#       "flakes"
#     ];
#     extra-substituters = [ "https://cache.xinux.uz/" ];
#     extra-trusted-public-keys = [ "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" ];
#     allow-import-from-derivation = true;
#   };
#   inputs = {
#     nixpkgs.url = "github:xinux-org/nixpkgs/nixos-25.11";
#     nixpkgs-unstable.url = "github:xinux-org/nixpkgs/nixos-unstable";
#     # Pre commit hooks for git
#     pre-commit-hooks = {
#       url = "github:cachix/git-hooks.nix";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#     relago-support.url = "github:xinux-org/relago-support";
#   };
#   outputs =
#     {
#       self,
#       nixpkgs,
#       flake-utils,
#       ...
#     }@inputs:
#     flake-utils.lib.eachDefaultSystem (
#       system:
#       let
#         pkgs = nixpkgs.legacyPackages.${system};
#       in
#       {
#         formatter = pkgs.nixfmt;
#         devShells.default = import ./shell.nix { inherit pkgs; };
#       }
#     )
#     // {
#       lib = nixpkgs.lib;
#       # nixosModules = import ./modules/nixos;
#       nixosConfigurations = {
#         nixos = nixpkgs.lib.nixosSystem {
#           specialArgs = { inherit inputs; };
#           modules = [
#             # > Our main nixos configuration file <
#             ./hosts/sholcha/configuration.nix
#           ];
#         };
#       };
#     };
# }
{
  description = "Configurations for various instances for educational purposes";

  # Extra nix configurations to inject to flake scheme
  # => use if something doesn't work out of box or when despaired...
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = ["https://cache.xinux.uz/"];
    extra-trusted-public-keys = ["cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="];
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

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    relago-support.url = "github:xinux-org/relago-support";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        # Allow unfree packages.
        allowUnfree = true;
      };
      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        inputs.relago-support.nixosModules.server
      ];
      # Configure Snowfall Lib, all of these settings are optional.
      snowfall = {
        # Choose a namespace to use for your flake's packages, library,
        # and overlays.
        namespace = "sholcha";

        # Add flake metadata that can be processed by tools like Snowfall Frost.
        meta = {
          # A slug to use in documentation when displaying things like file paths.
          name = "sholchac-config";

          # A title to show for your flake, typically the name.
          title = "My Awesome Flake";
        };
      };
    };
}
