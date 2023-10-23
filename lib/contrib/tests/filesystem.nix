{ filesystem }:

with filesystem;
{
  test_filesystem_filterValidPaths_01 = {
    expr = filterValidPaths [ ];
    expected = [ ];
  };

  test_filesystem_filterValidPaths_02 = {
    expr = filterValidPaths [ ./this/does/not/exist ];
    expected = [ ];
  };

  test_filesystem_filterValidPaths_03 = {
    expr = filterValidPaths [ ./this/does/not/exist ./filesystem/filterValidPaths ./filesystem/filterValidPaths/default.nix ];
    expected = [ ./filesystem/filterValidPaths ./filesystem/filterValidPaths/default.nix ];
  };

  test_filesystem_listDirs_01 = {
    expr = listDirs ./this/does/not/exist;
    expected = [ ];
  };

  test_filesystem_listDirs_02 = {
    expr = listDirs ./filesystem/listDirs;
    expected = [
      ./filesystem/listDirs/1
      ./filesystem/listDirs/2
      ./filesystem/listDirs/3
    ];
  };

  test_listDirsRecursive_01 = {
    expr = listDirsRecursive ./filesystem/listDirs;
    expected = [
      ./filesystem/listDirs/1
      ./filesystem/listDirs/2
      ./filesystem/listDirs/3
      ./filesystem/listDirs/1/10
      ./filesystem/listDirs/1/11
      ./filesystem/listDirs/2/20
      ./filesystem/listDirs/2/20/200
    ];
  };

}
