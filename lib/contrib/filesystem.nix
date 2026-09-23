{lib}: let
  inherit
    (builtins)
    isPath
    readDir
    ;
  inherit
    (lib)
    concatMap
    filter
    filterAttrs
    flipPipe
    foldl'
    head
    mapAttrsToList
    pathExists
    tail
    ;

  filterDirs = filterAttrs (_name: type: type == "directory");
in rec {
  /*
  Filter paths that exist from a list of paths

  Type: filterValidPaths :: [ path ] -> [ path ]
  */
  filterValidPaths = filter pathExists;

  /*
  Given a directory, return a list of all direct subdirectories
  within it.

  Type: listDirs :: path -> [ path ]
  */
  listDirs = dir: let
    asPath = mapAttrsToList (name: _type: dir + "/${name}");
  in
    if pathExists dir
    then flipPipe [readDir filterDirs asPath] dir
    else [];

  /*
  Given a directory, return a flattened list of all directories within it recursively.

  Type: path -> [ path ]
  */
  listDirsRecursive = dir: let
    go = dirsToList: res:
      if dirsToList == []
      then res
      else let
        subdirs = listDirs (head dirsToList);
      in
        go ((tail dirsToList) ++ subdirs) (res ++ subdirs);
  in
    go [dir] [];

  /**
  Return the paths that exist on disk out of every combination obtainable
  by joining, with "/", one element from each list in `segmentLists`, in order.

  # Inputs

  `segmentLists`

  : A list of lists of path segments. The first list's elements may be either
    `path` or `string` values (a `string` is normalized into an absolute `path`);
    every subsequent list's elements must be `string`s. The cartesian product is
    taken in list order: the first list varies slowest, the last list varies fastest.

  # Type

  ```
  crossValidPaths :: [ [ path | string ] ] -> [ path ]
  ```

  # Description

  This function computes the cartesian product of `segmentLists`, joining each
  combination's segments with `"/"` to form a candidate path, in the form:

  ```
  <segment1>/<segment2>/.../<segmentN>
  ```

  It then filters the resulting list to include only those paths that exist
  on disk, via `filterValidPaths`, and returns them as `path` values.

  # Examples
  :::{.example}
  ## `crossValidPaths` usage example

  ```nix
  crossValidPaths [
    [ /home ]
    [ "user1" "user2" "user3" ]
    [ "configuration.nix" "default.nix" ]
  ]
  =>
  [
    /home/user1/configuration.nix
    /home/user1/default.nix
    /home/user2/configuration.nix
    /home/user3/default.nix
  ]  # assuming these paths exist on disk
  ```
  :::
  */
  crossValidPaths = segmentLists: let
    toPath = s:
      if isPath s
      then s
      else (/. + s);
    combine = acc: segments:
      concatMap (prefix: map (segment: prefix + "/${segment}") segments) acc;
    combos =
      if segmentLists == []
      then []
      else foldl' combine (map toPath (head segmentLists)) (tail segmentLists);
  in
    filterValidPaths combos;
}
