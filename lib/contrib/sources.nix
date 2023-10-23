{ lib }:

let
  inherit (lib)
    const
    pathExists
    ;
in

{

  /*
    Imports a path if it exists or returns a default value
    otherwise

    Example:
      maybeImport { } ./non-existent-path
      => const { }
      maybeImport { default = [ ]; } ./non-existent-path
      => [ ]
  */
  maybeImport =
    {
      # Value to return case path does not exist
      # Optional with default value: function ( const { } )
      default ? const { }
    }: path:
    if pathExists path then import path else default;
}
