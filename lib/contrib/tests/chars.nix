{ chars }:

with chars;
{
  test_chars_isChar_01 = {
    expr = isChar "4";
    expected = true;
  };

  test_chars_isChar_02 = {
    expr = isChar "";
    expected = false;
  };

  test_chars_isChar_03 = {
    expr = isChar "abcd";
    expected = false;
  };

  test_chars_isBlankChar_01 = {
    expr = isBlankChar " ";
    expected = true;
  };

  test_chars_isBlankChar_02 = {
    expr = isBlankChar "\n";
    expected = true;
  };

  test_chars_isBlankChar_03 = {
    expr = isBlankChar "\t";
    expected = true;
  };

  test_chars_isBlankChar_04 = {
    expr = isBlankChar "\t";
    expected = true;
  };

  test_chars_isBlankChar_05 = {
    expr = isBlankChar "	";
    expected = true;
  };

  test_chars_isBlankChar_06 = {
    expr = isBlankChar "";
    expected = false;
  };

  test_chars_isBlankChar_07 = {
    expr = isBlankChar "a";
    expected = false;
  };

  test_chars_isBlankChar_08 = {
    expr = isBlankChar "abcde";
    expected = false;
  };

  test_chars_isNotBlankChar_01 = {
    expr = isNotBlankChar " ";
    expected = false;
  };

  test_chars_isNotBlankChar_02 = {
    expr = isNotBlankChar "\n";
    expected = false;
  };

  test_chars_isNotBlankChar_03 = {
    expr = isNotBlankChar "\t";
    expected = false;
  };

  test_chars_isNotBlankChar_04 = {
    expr = isNotBlankChar "\t";
    expected = false;
  };

  test_chars_isNotBlankChar_05 = {
    expr = isNotBlankChar "	";
    expected = false;
  };

  test_chars_isNotBlankChar_06 = {
    expr = isNotBlankChar "";
    expected = true;
  };

  test_chars_isNotBlankChar_07 = {
    expr = isNotBlankChar "a";
    expected = true;
  };

  test_chars_isNotBlankChar_08 = {
    expr = isNotBlankChar "abcde";
    expected = true;
  };
}
