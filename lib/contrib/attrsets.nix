{ lib }:

let
  inherit (builtins)
    toString
    ;
  inherit (lib)
    getAttr
    flipPipe
    listToAttrs
    nameValuePair
    ;
in

{

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
  indexAttrList = attrName:
    let
      indexFn = set: nameValuePair (toString (getAttr attrName set)) set;
    in
    flipPipe [ (map indexFn) listToAttrs ];

}
