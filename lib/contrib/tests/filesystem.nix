{filesystem}:
with filesystem; {
  test_filesystem_filterValidPaths_01 = {
    expr = filterValidPaths [];
    expected = [];
  };

  test_filesystem_filterValidPaths_02 = {
    expr = filterValidPaths [./this/does/not/exist];
    expected = [];
  };

  test_filesystem_filterValidPaths_03 = {
    expr = filterValidPaths [./this/does/not/exist ./filesystem/filterValidPaths ./filesystem/filterValidPaths/default.nix];
    expected = [./filesystem/filterValidPaths ./filesystem/filterValidPaths/default.nix];
  };

  test_filesystem_listDirs_01 = {
    expr = listDirs ./this/does/not/exist;
    expected = [];
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

  test_filesystem_crossValidPaths_01 = {
    expr = crossValidPaths [];
    expected = [];
  };

  test_filesystem_crossValidPaths_02 = {
    expr = crossValidPaths [[] ["a" "b"]];
    expected = [];
  };

  test_filesystem_crossValidPaths_03 = {
    expr = crossValidPaths [[./filesystem/crossValidPaths] ["this"] ["does" "not" "exist"]];
    expected = [];
  };

  test_filesystem_crossValidPaths_04 = {
    expr = crossValidPaths [
      [./filesystem/crossValidPaths]
      ["user1" "user2" "user3"]
      ["configuration.nix" "default.nix"]
    ];
    expected = [
      ./filesystem/crossValidPaths/user1/configuration.nix
      ./filesystem/crossValidPaths/user1/default.nix
      ./filesystem/crossValidPaths/user2/configuration.nix
      ./filesystem/crossValidPaths/user3/default.nix
    ];
  };
}
