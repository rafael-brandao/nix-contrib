{ attrsets }:

with attrsets;
{
  test_attrsets_indexAttrList_01 = {
    expr = indexAttrList "id" [
      { id = 0; name = "John"; }
      { id = 1; name = "Jane"; }
    ];
    expected = {
      "0" = { id = 0; name = "John"; };
      "1" = { id = 1; name = "Jane"; };
    };
  };
}
