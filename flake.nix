  {
    description = "Justin's Nix flakes";

    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }:
      let
        supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
        forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      in {
        # Expose the xcode module as a library function that can be imported
        lib = {
          xcode = import ./xcode.nix;
        };

        # Example: also expose it as a package if desired
        packages = forAllSystems (system:
          let
            pkgs = import nixpkgs { inherit system; };
          in {
            xcode = import ./xcode.nix { inherit pkgs; };
          }
        );
      };
  }

