use strict;
use warnings;
use FindBin qw/$Bin/;

use lib "$Bin/lib";

use Test::More tests => 3;
use Catalyst::Test 'MyApp';

my $res = request('/');
ok( $res->is_success, "/ is succcess" );

my $content = $res->decoded_content;
$content =~ m|plDebugPanelContent.+?<pre>(.*?)</pre>|s;
ok( $1, "debug panel is there" );

( my $stripped = $1 ) =~ s/\n\s*//gs;
is( $stripped, '{&#x27;ar&#x27; =&#x3E; [&#x27;bar&#x27;,1,2,3,{&#x27;key&#x27; =&#x3E; &#x27;value&#x27;},sub {package MyApp::Controller::Root;use warnings;use strict;my($one, $two) = @_;return $one + $two;}]}', 'panel content is correct' );

1;
