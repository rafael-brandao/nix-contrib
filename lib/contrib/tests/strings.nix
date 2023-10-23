{ strings }:

with strings;
{
  test_strings_isBlankString_01 = {
    expr = isBlankString "";
    expected = true;
  };

  test_strings_isBlank_String02 = {
    expr = isBlankString "             				   ";
    expected = true;
  };

  test_strings_isBlankString_03 = {
    expr = isBlankString "56";
    expected = false;
  };

  test_strings_isBlankString_04 = {
    expr = isBlankString "  				   208   				    ";
    expected = false;
  };

  test_strings_isBlankString_05 = {
    expr = isBlankString ''
                    
  																				   
                              
                              
                              '';
    expected = true;
  };


  test_strings_isBlankString_06 = {
    expr = isBlankString ''
      								            
      NOT BLANK            
              				              
    '';
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
    expr = isNotBlankString "   				     ";
    expected = false;
  };

  test_strings_isNotBlankString_03 = {
    expr = isNotBlankString "56";
    expected = true;
  };

  test_strings_isNotBlankString_04 = {
    expr = isNotBlankString "         208    				   ";
    expected = true;
  };

  test_strings_isNotBlankString_05 = {
    expr = isNotBlankString ''
      								
                              

                              
    '';
    expected = false;
  };

  test_strings_isNotBlankString_06 = {
    expr = isNotBlankString ''
                  								
      NOT BLANK           				 
                              
    '';
    expected = true;
  };

  test_strings_isNotBlankString_07 = {
    expr = isNotBlankString "   \n   \t   \r   ";
    expected = false;
  };

  test_strings_mkString_01 = {
    expr = mkString { } [ 1 2 3 4 5 ];
    expected = "12345";
  };

  test_strings_mkString_02 = {
    expr = mkString { sep = ", "; } [ 1 2 3 4 5 ];
    expected = "1, 2, 3, 4, 5";
  };

  test_strings_mkString_03 = {
    expr = mkString { start = "{ "; sep = ", "; end = " }"; } [ 1 2 3 4 5 ];
    expected = "{ 1, 2, 3, 4, 5 }";
  };

  test_strings_trim_01 = {
    expr = trim "   \n 			  \t   \r   TEST   \n   \t   \r  		";
    expected = "TEST";
  };

  test_strings_trim_02 = {
    expr = trim "   \n 			  \t   \r      \n   \t   \r  		";
    expected = "";
  };

  test_strings_trim_03 = {
    expr = trim ''
                  								
      NOT BLANK           				 
                              
    '';
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
    expr = trim ''
                  								
      START           				 
      MIDLE           				 
                END           				 
                              
    '';

    expected = ''
      START           				 
      MIDLE           				 
                END'';
  };

  test_strings_splitTrim_01 = {
    expr = splitTrim "\n" ''
      This 
      is 
      a 
      multiline 
      string
    '';
    expected = [ "This" "is" "a" "multiline" "string" ];
  };

  test_strings_splitTrimConcatLines_01 = {
    expr = splitTrimConcatLines ", " ''
      -Xms100m
      -Xmx1G
      -XX:+UseParallelGC
    '';
    expected = "-Xms100m, -Xmx1G, -XX:+UseParallelGC";
  };
}
