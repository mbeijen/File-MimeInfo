
use Test::More tests => 2;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forceing non default value

$ENV{CHOICESPATH} = './t';

use_ok(q/File::MimeInfo::Rox/);

is_deeply(
	[File::MimeInfo::Rox::suggest_script_name('video/mpeg')],
	['./t/MIME-types', 'video_mpeg'],
	'suggest_script_name works' );

# dunno what more to test :S

