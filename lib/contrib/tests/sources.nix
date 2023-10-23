{ sources }:

with sources;
{
  test_sources_maybeImport_01 = {
    expr = (maybeImport { } ./this/does/not/exist) "any";
    expected = { };
  };

  test_sources_maybeImport_02 = {
    expr = maybeImport { } ./sources/maybeImport;
    expected = "I am a valid result";
  };

  test_sources_maybeImport_03 = {
    expr = maybeImport { default = 5; } ./this/does/not/exist;
    expected = 5;
  };
}
