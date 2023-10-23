{ trivial }:

with trivial;
{

  test_trivial_allMatch_01 = {
    expr = allMatch [ builtins.isString isNullOrEmpty ] "test-string";
    expected = false;
  };

  test_trivial_allMatch_02 = {
    expr = allMatch [ builtins.isString isNotNullOrEmpty ] "test-string";
    expected = true;
  };

  test_trivial_allMatch_03 = {
    expr = allMatch [ builtins.isString isNotNullOrEmpty ] "";
    expected = false;
  };

  test_trivial_anyMatch_01 = {
    expr = anyMatch [ builtins.isString isNullOrEmpty ] "test-string";
    expected = true;
  };

  test_trivial_anyMatch_02 = {
    expr = anyMatch [ builtins.isString isNotNullOrEmpty ] "test-string";
    expected = true;
  };

  test_trivial_anyMatch_03 = {
    expr = anyMatch [ builtins.isString isNotNullOrEmpty ] "";
    expected = true;
  };

  test_trivial_isEmpty_01 = {
    expr = isEmpty { f = "f"; };
    expected = false;
  };

  test_trivial_isEmpty_02 = {
    expr = isEmpty [ ];
    expected = true;
  };

  test_trivial_isEmpty_03 = {
    expr = isEmpty "80";
    expected = false;
  };

  test_trivial_isEmpty_04 = {
    expr = builtins.tryEval (isEmpty null);
    expected = { success = false; value = false; };
  };

  test_trivial_isEmpty_05 = {
    expr = builtins.tryEval (isEmpty 6);
    expected = { success = false; value = false; };
  };

  test_trivial_isNotEmpty_01 = {
    expr = isNotEmpty { f = "f"; };
    expected = true;
  };

  test_trivial_isNotEmpty_02 = {
    expr = isNotEmpty [ ];
    expected = false;
  };

  test_trivial_isNotEmpty_03 = {
    expr = isNotEmpty "80";
    expected = true;
  };

  test_trivial_isNotEmpty_04 = {
    expr = builtins.tryEval (isNotEmpty null);
    expected = { success = false; value = false; };
  };

  test_trivial_isNotEmpty_05 = {
    expr = builtins.tryEval (isNotEmpty 6);
    expected = { success = false; value = false; };
  };

  test_trivial_isNullOrEmpty_01 = {
    expr = isNullOrEmpty { f = "f"; };
    expected = false;
  };

  test_trivial_isNullOrEmpty_02 = {
    expr = isNullOrEmpty [ ];
    expected = true;
  };

  test_trivial_isNullOrEmpty_03 = {
    expr = isNullOrEmpty "80";
    expected = false;
  };

  test_trivial_isNullOrEmpty_04 = {
    expr = isNullOrEmpty null;
    expected = true;
  };

  test_trivial_isNullOrEmpty_05 = {
    expr = builtins.tryEval (isNullOrEmpty 6);
    expected = { success = false; value = false; };
  };

  test_trivial_isNotNullOrEmpty_01 = {
    expr = isNotNullOrEmpty { f = "f"; };
    expected = true;
  };

  test_trivial_isNotNullOrEmpty_02 = {
    expr = isNotNullOrEmpty [ ];
    expected = false;
  };

  test_trivial_isNotNullOrEmpty_03 = {
    expr = isNotNullOrEmpty "80";
    expected = true;
  };

  test_trivial_isNotNullOrEmpty_04 = {
    expr = isNotNullOrEmpty null;
    expected = false;
  };

  test_trivial_isNotNullOrEmpty_05 = {
    expr = builtins.tryEval (isNotNullOrEmpty 6);
    expected = { success = false; value = false; };
  };
}
