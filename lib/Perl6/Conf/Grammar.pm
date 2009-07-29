grammar Perl6::Conf::Grammar {
    token TOP               { ^ <ini> $ };
    token ini {
        <comment>* <section>* <comment>*
    }
    token comment {
        ^^ <ws> [ '#' \N* ]? $$ \n? 
#        {{ print "comment\n" }}
    }
  
    token section {
        <header> [<comment>* <entry>]*
    }
    token header {
        ^^ \[ <-[\]]>* \] $$ \n?
    }
    token entry {
        ^^ <key> <ws> '=' <ws> <value> $$ \n?
#        {{ print "entry\n" }}
    }
    token key {
        <alnum>+
    }
    token value {
        \N+
    }
}


# 	regex TOP { ^ <comment>* <section>* $ }; 
# 
# 	regex section { <heading> <body> };
# 	regex body { <chunk>* };
# 	regex chunk { <comment> | <entry> };
# 	regex heading { ^^ '[' <ident> ']' $$ };
# 
# 	regex entry { ^^ <key> \= <value> $$ };
# 	regex key   { \w+ };
# 	regex value { \N+ };
# 	regex ident { \w+ };
# 	regex comment { ^^ \s* (\#\N*)? $$ };  # comment and empty line


