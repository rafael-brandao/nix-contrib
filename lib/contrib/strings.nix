{ lib }:

let
  inherit (lib)
    all
    any
    allMatch
    anyMatch
    concatMapStringsSep
    concatStringsSep
    const
    elemAt
    filter
    flipPipe
    id
    isBlankChar
    isNotBlankChar
    isString
    length
    splitString
    stringToCharacters
    substring
    ;

in
rec {

  /*
    Test if a string is blank

    Type: isBlankString :: string -> bool

    Example:
      isBlankString "foo"
      => false
      isBlankString "
      => true
      isBlankString "     "
      => true
      isBlankString "   \n   \t   \r   "
      => true
  */
  isBlankString = anyMatch [
    isEmptyString
    (allMatch [
      isString
      (flipPipe [ stringToCharacters (all isBlankChar) ])
    ])
  ];


  /*
    Test if a string is empty

    Type: isEmptyString :: string -> bool

    Example:
      isEmptyString "foo"
      => false
      isEmptyString ""
      => true
      isEmptyString "     "
      => false
      isEmptyString "   \n   \t   \r   "
      => false
  */
  isEmptyString = s: s == "";


  /*
    Test if a string is not blank

    Type: isNotBlankString :: string -> bool

    Example:
      isNotBlankString "foo"
      => true
      isNotBlankString "
      => false
      isNotBlankString "     "
      => false
      isNotBlankString "   \n   \t   \r   "
      => false
  */
  isNotBlankString = allMatch [
    isNotEmptyString
    (allMatch [
      isString
      (flipPipe [ stringToCharacters (any isNotBlankChar) ])
    ])
  ];


  /*
    Test if a string is not empty

    Type: isNotEmptyString :: string -> bool

    Example:
      isNotEmptyString "foo"
      => true
      isNotEmptyString ""
      => false
      isNotEmptyString "     "
      => true
      isNotEmptyString "   \n   \t   \r   "
      => true
  */
  isNotEmptyString = s: s != null && s != "";


  /*
    Displays all elements of a list in a string
    using start, end, and separator strings

    Example:
      mkString { start = "{ "; sep = ", "; end = " }"; } [ 1 2 3 4 5 ]
      => "{ 1, 2, 3, 4, 5 }"
      mkString { } [ 1 2 3 4 5 ]
      => "12345"
  */
  mkString =
    {
      # The starting string
      # Optional with default value: empty string ""
      start ? ""
    , # The separator string
      # Optional with default value: empty string ""
      sep ? ""
    , # The ending string
      # Optional with default value: empty string ""
      end ? ""
    }: list:
    "${start}${concatMapStringsSep sep toString list}${end}";


  /*
    An enhanced version of `splitString` that cuts a string with a
    separator, producing a list of strings which may be modified by
    a map function and a filter function.

    Example:
      splitMapFilter { sep =  "."; } "foo.bar.baz"
      => [ "foo" "bar" "baz" ]
      splitMapFilter { sep = "/"; filter = s: s != ""; } "/usr/local/bin"
      => [ "usr" "local" "bin" ]
  */
  splitMapFilter =
    {
      # The separator string
      sep
    , # The map function
      # Optional with default value: function id
      mapFn ? id
    , # The filter function
      # Optional with default value: function (const true)
      filterFn ? const true
    }:
    flipPipe [ (splitString sep) (map mapFn) (filter filterFn) ];


  /*
    Specialized version of `splitMapFilter` that cuts a string with a
    separator, producing a list of strings that are trimed and filtered
    out when enpty.

    Example:
      splitTrim "\n" ''
        This 
        is 
        a 
        multiline 
        string
      ''
      => [ "This" "is" "a" "multiline" "string" ]
  */
  splitTrim = sep:
    splitMapFilter {
      inherit sep;
      mapFn = trim;
      filterFn = isNotEmptyString;
    };


  /*
    Applies the `splitTrim "\n"` function and concats the result string list
    with a join separator.

    Example:
    splitTrimConcatLines ", " ''
      -Xms100m
      -Xmx1G
      -XX:+UseParallelGC
    ''
    => "-Xms100m, -Xmx1G, -XX:+UseParallelGC"
  */
  splitTrimConcatLines = sep:
    flipPipe [ (splitTrim "\n") (concatStringsSep sep) ];


  /*
    Eliminates leading and trailing blank chars from a string

    Type: trim :: string -> string

    Example:
      trim "   test    "
      => "test"
  */
  trim = string:
    let
      chars = stringToCharacters string;
      charsLength = length chars;

      calculateIndexes = left: right:
        if (left > right) then { start = 0; len = 0; }
        else
          let
            leftChar = elemAt chars left;
            rightChar = elemAt chars right;
          in
          if (isNotBlankChar leftChar) && (isNotBlankChar rightChar) then
            { start = left; len = right - left + 1; }
          else if (isBlankChar leftChar) && (isBlankChar rightChar) then
            calculateIndexes (left + 1) (right - 1)
          else if (isNotBlankChar leftChar) && (isBlankChar rightChar) then
            calculateIndexes left (right - 1)
          else calculateIndexes (left + 1) right;

      indexes = calculateIndexes 0 (charsLength - 1);
    in
    substring indexes.start indexes.len string;

}
