{strings}:
with strings; {
  test_strings_isBlankString_01 = {
    expr = isBlankString "";
    expected = true;
  };

  test_strings_isBlank_String02 = {
    expr = isBlankString "             \t\t\t\t   ";
    expected = true;
  };

  test_strings_isBlankString_03 = {
    expr = isBlankString "56";
    expected = false;
  };

  test_strings_isBlankString_04 = {
    expr = isBlankString "  \t\t\t\t   208   \t\t\t\t    ";
    expected = false;
  };

  test_strings_isBlankString_05 = {
    expr = isBlankString "\n\n\n\n\n    ";
    expected = true;
  };

  test_strings_isBlankString_06 = {
    expr = isBlankString "\n  NOT BLANK\n\n";
    expected = false;
  };

  test_strings_isBlankString_07 = {
    expr = isBlankString "   \n   \t   \r   ";
    expected = true;
  };

  test_strings_isNotBlankString_01 = {
    expr = isNotBlankString "";
    expected = false;
  };

  test_strings_isNotBlank_String02 = {
    expr = isNotBlankString "   \t\t\t\t     ";
    expected = false;
  };

  test_strings_isNotBlankString_03 = {
    expr = isNotBlankString "56";
    expected = true;
  };

  test_strings_isNotBlankString_04 = {
    expr = isNotBlankString "         208    \t\t\t\t   ";
    expected = true;
  };

  test_strings_isNotBlankString_05 = {
    expr = isNotBlankString "\n\n\n\n\n    ";
    expected = false;
  };

  test_strings_isNotBlankString_06 = {
    expr = isNotBlankString "\n  NOT BLANK\n\n";
    expected = true;
  };

  test_strings_isNotBlankString_07 = {
    expr = isNotBlankString "   \n   \t   \r   ";
    expected = false;
  };

  test_strings_mkString_01 = {
    expr = mkString {} [1 2 3 4 5];
    expected = "12345";
  };

  test_strings_mkString_02 = {
    expr = mkString {sep = ", ";} [1 2 3 4 5];
    expected = "1, 2, 3, 4, 5";
  };

  test_strings_mkString_03 = {
    expr = mkString {
      start = "{ ";
      sep = ", ";
      end = " }";
    } [1 2 3 4 5];
    expected = "{ 1, 2, 3, 4, 5 }";
  };

  test_strings_trim_01 = {
    expr = trim "   \n \t\t\t\t\t\t  \t   \r   TEST   \n   \t   \r  \t\t\t";
    expected = "TEST";
  };

  test_strings_trim_02 = {
    expr = trim "   \n \t\t\t\t\t\t  \t   \r      \n   \t   \r  \t\t\t";
    expected = "";
  };

  test_strings_trim_03 = {
    expr = trim "\n  NOT BLANK\n\n";
    expected = "NOT BLANK";
  };

  test_strings_trim_04 = {
    expr = trim " ";
    expected = "";
  };

  test_strings_trim_05 = {
    expr = trim "  ";
    expected = "";
  };

  test_strings_trim_06 = {
    expr = trim "   ";
    expected = "";
  };

  test_strings_trim_07 = {
    expr = trim "";
    expected = "";
  };

  test_strings_trim_08 = {
    expr = trim "\nSTART\t\t\t\t \nMIDLE\t\t\t\t \n          END\n";

    expected = "START\t\t\t\t \nMIDLE\t\t\t\t \n          END";
  };

  test_strings_splitTrim_01 = {
    expr = splitTrim "\n" "This\nis\na\nmultiline\nstring";
    expected = ["This" "is" "a" "multiline" "string"];
  };

  test_strings_splitTrimConcatLines_01 = {
    expr = splitTrimConcatLines ", " "-Xms100m\n-Xmx1G\n-XX:+UseParallelGC";
    expected = "-Xms100m, -Xmx1G, -XX:+UseParallelGC";
  };
}
