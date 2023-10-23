# to run these tests:
# nix eval .#tests
# if the resulting list is empty, all tests passed
{ lib-contrib, lib-nixpkgs }:
let
  inherit (lib-nixpkgs)
    attrValues
    foldl'
    flip
    pipe
    runTests
    ;

  mergeAttrValues = foldl' (set1: set2: (set1 // set2)) { };

  tests = {
    attrsets = import ./attrsets.nix { inherit (lib-contrib) attrsets; };
    chars = import ./chars.nix { inherit (lib-contrib) chars; };
    filesystem = import ./filesystem.nix { inherit (lib-contrib) filesystem; };
    strings = import ./strings.nix { inherit (lib-contrib) strings; };
    sources = import ./sources.nix { inherit (lib-contrib) sources; };
    trivial = import ./trivial.nix { inherit (lib-contrib) trivial; };
  };
in
{
  all = flip pipe [ attrValues mergeAttrValues runTests ] tests;

  attrsets = runTests tests.attrsets;
  chars = runTests tests.chars;
  filesystem = runTests tests.filesystem;
  strings = runTests tests.strings;
  sources = runTests tests.sources;
  trivial = runTests tests.trivial;
}
