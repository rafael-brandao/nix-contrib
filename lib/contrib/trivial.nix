{ lib }:

let
  inherit (builtins)
    map
    toString
    typeOf
    ;
  inherit (lib)
    all
    any
    concatStringsSep
    flip
    pipe
    throwIfNot
    ;
  inherit (lib.strings)
    escapeNixString
    ;

  emptyTypes = [ "list" "set" "string" ];
  nullOrEmptyTypes = emptyTypes ++ [ "null" ];

  testEmptyness = functionName: acceptedTypes: testFunction:
    let
      requireType = x:
        let
          type = typeOf x;
          isAcceptedType = any (t: t == type) acceptedTypes;
          errorMsg =
            "${functionName}: invalid argument: ${toString x} :: ${escapeNixString type}; accepted type is one of: ${concatStringsSep ", " (map escapeNixString acceptedTypes)}";
        in
        throwIfNot isAcceptedType errorMsg x;
    in
    flip pipe [ requireType testFunction ];

  isEmptyFn = x: [ ] == x || { } == x || "" == x;
  isNotEmptyFn = x: !(isEmptyFn x);
  isNullOrEmptyFn = x: x == null || isEmptyFn x;
  isNotNullOrEmptyFn = x: !(isNullOrEmptyFn x);

in
{

  /*
    Test a value over a list of predicates.
    Returns true if all predicates evaluate to true

    Type: allMatch :: [ (a -> bool) ] -> a -> bool

    Example:
      allMatch [ isString isNullOrEmpty ] "test-string"
      => false
      allMatch [ isString isNotNullOrEmpty ] "test-string"
      => true
      allMatch [ isString isNotNullOrEmpty ] ""
      => false
  */
  allMatch = predicates: value:
    all (pred: pred value) predicates;


  /*
    Test a value over a list of predicates.
    Returns true on the first predicate that evaluate to true

    Type: anyMatch :: [ (a -> bool) ] -> a -> bool

    Example:
      anyMatch [ isString isNullOrEmpty ] "test-string"
      => true
      anyMatch [ isString isNotNullOrEmpty ] "test-string"
      => true
      anyMatch [ isString isNotNullOrEmpty ] ""
      => true
  */
  anyMatch = predicates: value:
    any (pred: pred value) predicates;


  /*
    Inverts the argument order of the `pipe` function.
    This makes function composition easier.

    Type: flipPipe :: [<functions>] -> a -> <return type of last function>

    Example:
      flipPipe [
         (x: x + 2)  # 2 + 2 = 4
         (x: x * 2)  # 4 * 2 = 8
      ] 2
      => 8
  */
  flipPipe = flip pipe;


  /*
    Generic function that checks if a list or a set or a string is empty.
    Throws an indicative error if argument type is not a list or a set or a string

    Type: isEmpty :: a -> bool

    Example:
    isEmpty { f = "f"; }
    => false
    isEmpty [ ]
    => true
    isEmpty "80"
    => false
    isEmpty null
    => error: isEmpty: invalid argument:  :: "null"; accepted type is one of: "list", "set", "string"
    isEmpty 6
    => error: isEmpty: invalid argument: 6 :: "int"; accepted type is one of: "list", "set", "string"
  */
  isEmpty = testEmptyness "isEmpty" emptyTypes isEmptyFn;


  /*
    Like isEmpty, but negated (when passed argument is not empty)
    Throws an indicative error if argument type is not a list or a set or a string

    Type: isNotEmpty :: a -> bool

    Example:
    isNotEmpty { f = "f"; }
    => true
    isNotEmpty [ ]
    => false
    isNotEmpty "80"
    => true
    isNotEmpty null
    => error: isNotEmpty: invalid argument:  :: "null"; accepted type is one of: "list", "set", "string"
    isNotEmpty 6
    => error: isNotEmpty: invalid argument: 6 :: "int"; accepted type is one of: "list", "set", "string"
  */
  isNotEmpty = testEmptyness "isNotEmpty" emptyTypes isNotEmptyFn;


  /*
    Generic function that checks if a list or a set or a string is null or empty.
    Throws an indicative error if argument type is not a list or a set or a string or null

    Type: isNullOrEmpty :: a -> bool

    Example:
    isNullOrEmpty { f = "f"; }
    => false
    isNullOrEmpty [ ]
    => true
    isNullOrEmpty "80"
    => false
    isNullOrEmpty null
    => true
    isNullOrEmpty 6
    => isNullOrEmpty: invalid argument: 6 :: "int"; accepted type is one of: "list", "set", "string", "null"
  */
  isNullOrEmpty = testEmptyness "isNullOrEmpty" nullOrEmptyTypes isNullOrEmptyFn;


  /*
    Like isNullOrEmpty, but negated (when passed argument is not null and not empty)
    Throws an indicative error if argument type is not a list or a set or a string or null

    Type: isNotNullOrEmpty :: a -> bool

    Example:
    isNotNullOrEmpty { f = "f"; }
    => true
    isNotNullOrEmpty [ ]
    => false
    isNotNullOrEmpty "80"
    => true
    isNotNullOrEmpty null
    => false
    isNotNullOrEmpty 6
    => isNotNullOrEmpty: invalid argument: 6 :: "int"; accepted type is one of: "list", "set", "string", "null"
  */
  isNotNullOrEmpty = testEmptyness "isNotNullOrEmpty" nullOrEmptyTypes isNotNullOrEmptyFn;


  /*
    Function that negates a boolean.

    Type: not :: bool -> bool

    Example:
    not true
    => false
    not false
    => true

    # useful in function compositions
  */
  not = x: !x;

}
