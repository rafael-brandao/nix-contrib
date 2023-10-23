let
  inherit (builtins.fromJSON (builtins.readFile ./flake.lock)) nodes;
  # Fetch using flake lock, for legacy compat
  fromFlake = name:
    let inherit (nodes.${name}) locked;
    in fetchTarball {
      url =
        "https://github.com/${locked.owner}/${locked.repo}/archive/${locked.rev}.tar.gz";
      sha256 = locked.narHash;
    };

in
{ lib-nixpkgs ? (import ((fromFlake "nixpkgs-lib") + "/lib"))
, ...
}:
rec {

  lib-contrib = import ./lib/contrib { inherit lib-nixpkgs; };

  lib = lib-nixpkgs.extend (previous: final: (lib-contrib // final));

  tests = import ./lib/contrib/tests { inherit lib-contrib; inherit lib-nixpkgs; };

}
