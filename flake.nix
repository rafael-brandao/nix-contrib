{
  description =
    "Contrib collection of additional nix library functions.";

  inputs = {
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = { self, nixpkgs-lib }:
    import ./. {
      nixpkgs-lib = nixpkgs-lib.lib;
    };
}