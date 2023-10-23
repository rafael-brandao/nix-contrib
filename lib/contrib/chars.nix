{ lib }:

let
  inherit (lib)
    all
    any
    isString
    length
    stringToCharacters
    ;

  blankChars = [ " " "\n" "\r" "\t" ];

in
{

  /*
    Return true if e evaluates to a string that has
    lenght == 1, and false otherwise.

    Type: isChar :: a -> bool
  */
  isChar = e: (isString e) && (length (stringToCharacters e) == 1);

  /*
    Return true if e evaluates to a string that equals to
    a blank space or a line feed or a carriage return or
    a tab, and false otherwise.

    Type: isBlankChar :: a -> bool
  */
  isBlankChar = e: any (c: e == c) blankChars;

  /*
    Return false if e evaluates to a string that equals to
    a blank space or a line feed or a carriage return or
    a tab, and true otherwise.

    Type: isNotBlankChar :: a -> bool
  */
  isNotBlankChar = e: all (c: e != c) blankChars;

}
