use v6;

use Test;

plan => 21;

use Perl6::Conf::Grammar;
ok(1, 'loaded Perl6::Conf::Grammar and still alive');

Perl6::Conf::Grammar.parse('');
is($/, '', 'empty string is ok');

Perl6::Conf::Grammar.parse('abc');
is($/, '', 'abc does not match');


my $str_1 = '# first comment';
Perl6::Conf::Grammar.parse($str_1);
is($/, $str_1, 'one comment');
is($/<ini>, $str_1,          '<ini>');
is($/<ini><comment>, $str_1, '<ini><comment>');

my $str_2 = "# second comment with newline\n";
Perl6::Conf::Grammar.parse($str_2);
is($/, $str_2, "comment with newlie");
is($/<ini>, $str_2, '<ini>');
is($/<ini><comment>, $str_2, '<ini><comment>');

my $str_3 = "   # indented comment\n";
Perl6::Conf::Grammar.parse($str_3);
is($/, $str_3, 'indented comment');

my $str_4 = "#nospace comment  \n";
Perl6::Conf::Grammar.parse($str_4);
is($/, $str_4, 'nospace comment');

my $str_5 =  "     ";
Perl6::Conf::Grammar.parse($str_5);
is($/, $str_5, 'empty line');

#my $str_5 =  "     \n";
#Perl6::Conf::Grammar.parse($str_5);
#is($/, $str_5, 'empty line with newline');

my $str_6 = "# one comment\n\n# comment 2";
Perl6::Conf::Grammar.parse($str_6);
is($/, $str_6, 'three lines');

my @str_7 = "# comment\n", "[name]\n";
my $str_7 = @str_7.join('');
Perl6::Conf::Grammar.parse($str_7);
is($/, $str_7, 'comment and section');
is($/<ini>, $str_7, 'comment and section <ini>');
is($/<ini><comment>, @str_7[0], 'comment and section <ini><comment>');
is($/<ini><section><header>, @str_7[1], '<header>');

my @str_8 = 
	"# comment before\n",
	"[apple]\n",
	"# some comment\n",
	"color = red\n",
	"shape = round\n";
my $str_8 = @str_8.join('');
Perl6::Conf::Grammar.parse($str_8);
is($/, $str_8, 'section and elements');
is($/<ini><comment>, @str_8[0], '1st comment');
is($/<ini><comment>[0], @str_8[0], '1st comment');
#diag $/<ini><section>;
is($/<ini><section><entry><header>, @str_8[1], 'header');
is($/<ini><section><entry><comment>, @str_8[2], '2nd comment');

#diag "entry '$/<ini><section><entry>'";

#diag $/<ini>.perl;

#is($/<ini><section><comment>, @str_8[2], '2nd comment');
#is($/<ini><section><header>, 'apple', 'header');
#diag $/<ini><section>.keys.map("<$_>");

my @str_9 = 
	"[apple]   \n",
	"a=b";
my $str_9 = @str_9.join("\n");
Perl6::Conf::Grammar.parse($str_9);
#is($/, $str_9, 'section on the first line with spaces after it');


# # [<comment>* <entry>*]*
# # \[  <alnum>+ \]

# my $file_2 = "
# 
# # comment in the apple
# 
# [banana]
# ";
# my $file_3 = "
# 
# 
# 
# color = yellow
# 
#   # comment in banana
# 
# shape = curve
# ";
# 
# B.parse($file_2);
# say $/;
# 
# 
# 
