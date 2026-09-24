{lib}: let
  inherit
    (lib)
    filter
    getAttr
    flipPipe
    listToAttrs
    nameValuePair
    ;
in {
  /*
  Indexes a list of atrrsets by an attribute name
  All attrsets in this list must have the attribute name to index

  Type: indexAttrList :: string -> [<sets>] -> { set }

  Example:
  indexAttrList [
    { id = 0; name = "John"; }
    { id = 1; name = "Jane"; }
  ]
  => {
    "0" = { id = 0; name = "John"; };
    "1" = { id = 1; name = "Jane"; };
  }
  */
  indexAttrList = attrName: let
    indexFn = set: nameValuePair (toString (getAttr attrName set)) set;
  in
    flipPipe [(map indexFn) listToAttrs];

  /**
    Return the values from `attrset` whose keys are present in `keys`.

    # Inputs

    `keys`
    : A list of strings to look up in `attrset`.

    `attrset`
    : The attribute set to select values from.

    # Type
    ```
    withMatching :: [String] -> AttrSet -> [Any]
    ```

    # Description

    This function filters `keys` down to only those that exist as attribute
    names in `attrset`, then maps each remaining key to its corresponding
    value in `attrset`.

    Keys with no matching attribute in `attrset` are silently dropped; the
    order of the returned list follows the order of `keys`, not the order
    of `attrset`.

    Internally, it uses `lib.filter` to keep only matching keys, then `map`
    to resolve each key to its value.

    # Examples
    :::{.example}
    ## `withMatching` usage example

    ```nix
        withMatching
          [ "a" "c" "z" ]
          { a = 1; b = 2; c = 3; }
        =>
        [ 1 3 ]  # "z" is dropped, since it has no matching key in the attrset
    ```
    :::
  */
  withMatching = keys: attrset:
    map (k: attrset.${k})
    (filter (k: attrset ? ${k}) keys);
}
