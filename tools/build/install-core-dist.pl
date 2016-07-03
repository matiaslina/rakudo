use lib <lib>;
use CompUnit::Repository::Staging;
my %provides = 
    "TAP"                           => "lib/TAP.pm6",
    "Test"                          => "lib/Test.pm6",
    "NativeCall"                    => "lib/NativeCall.pm6",
    "NativeCall::Types"             => "lib/NativeCall/Types.pm6",
    "NativeCall::Compiler::GNU"     => "lib/NativeCall/Compiler/GNU.pm6",
    "NativeCall::Compiler::MSVC"    => "lib/NativeCall/Compiler/MSVC.pm6",
    "Pod::To::Text"                 => "lib/Pod/To/Text.pm6",
    "newline"                       => "lib/newline.pm6",
    "experimental"                  => "lib/experimental.pm6",
    "CompUnit::Repository::Staging" => "lib/CompUnit/Repository/Staging.pm",
;

$*REPO; # init repo chain so AbsolutePath and NQP repos are available during precomp
PROCESS::<$REPO> := CompUnit::Repository::Staging.new(
    :prefix(@*ARGS[0]),
    :next-repo(CompUnit::RepositoryRegistry.repository-for-name('perl')),
    :name('perl'),
);
$*REPO.install(
    Distribution::Hash.new(
        {
            name     => "CORE",
            auth     => "perl",
            ver      => $*PERL.version.Str,
            provides => %provides,
        },
        prefix => $*CWD,
    ),
    :force,
);

note "installed!";

# vim: ft=perl6
