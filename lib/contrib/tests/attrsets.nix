{attrsets}:
with attrsets; {
  test_attrsets_indexAttrList_01 = {
    expr = indexAttrList "id" [
      {
        id = 0;
        name = "John";
      }
      {
        id = 1;
        name = "Jane";
      }
    ];
    expected = {
      "0" = {
        id = 0;
        name = "John";
      };
      "1" = {
        id = 1;
        name = "Jane";
      };
    };
  };

  test_attrsets_withMatching_01 = {
    expr = withMatching [] {};
    expected = [];
  };

  test_attrsets_withMatching_02 = {
    expr = withMatching [] {
      a = 1;
      b = 2;
      c = 3;
    };
    expected = [];
  };

  test_attrsets_withMatching_03 = {
    expr = withMatching ["a" "b"] {};
    expected = [];
  };

  test_attrsets_withMatching_04 = {
    expr = withMatching ["a" "c" "z"] {
      a = 1;
      b = 2;
      c = 3;
    };
    expected = [1 3];
  };

  test_attrsets_withMatching_05 = {
    expr = withMatching ["c" "a" "b"] {
      a = 1;
      b = 2;
      c = 3;
    };
    expected = [3 1 2];
  };

  test_attrsets_withMatching_06 = {
    expr = withMatching ["z" "y" "x"] {
      a = 1;
      b = 2;
    };
    expected = [];
  };
}
