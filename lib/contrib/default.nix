{lib-nixpkgs}: let
  inherit (lib-nixpkgs) makeExtensible;

  lib-contrib = makeExtensible (self: let
    callLibs = file: import file {lib = lib-nixpkgs.extend (_previous: final: (self // final));};
  in {
    attrsets = callLibs ./attrsets.nix;
    chars = callLibs ./chars.nix;
    filesystem = callLibs ./filesystem.nix;
    strings = callLibs ./strings.nix;
    sources = callLibs ./sources.nix;
    trivial = callLibs ./trivial.nix;

    inherit
      (self.attrsets)
      indexAttrList
      ;

    inherit
      (self.chars)
      isChar
      isBlankChar
      isNotBlankChar
      ;

    inherit
      (self.filesystem)
      crossValidPaths
      filterValidPaths
      listDirs
      listDirsRecursive
      ;

    inherit
      (self.strings)
      isBlankString
      isEmptyString
      isNotBlankString
      isNotEmptyString
      mkString
      splitMapFilter
      splitTrim
      splitTrimConcatLines
      trim
      ;

    inherit
      (self.sources)
      maybeImport
      ;

    inherit
      (self.trivial)
      allMatch
      anyMatch
      flipPipe
      isEmpty
      isNotEmpty
      isNullOrEmpty
      isNotNullOrEmpty
      not
      ;
  });
in
  lib-contrib
