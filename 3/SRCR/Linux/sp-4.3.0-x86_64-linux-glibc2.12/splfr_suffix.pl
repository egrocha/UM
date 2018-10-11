#!@PERL@ -w
# -*- Mode:perl -*-
# ** NOTE ** @VAR@ are substituted by Utils/Makefile (by configure only for binary installs)
#################################################################################
# Description:    Perl source-code for splfr. "splfr --help" for usage info.
#################################################################################

# [PM] 3.9 Lines starting with "## PLFRM " have been (automatically) commented out for this platform.
# [PM] 3.9 lines containing <hash> @ONLYWIN32@ will be removed on non-windows
# [PM] 4.2 lines containing <hash> ... @ONLYNONMACOSX@ will be removed on Mac OS X (note that this need not come immediately after the hash mark)

# [PM] 4.0.2+ strict and warnings. If you turn this off consider the
# immortal words of Dirty Harry: "... you've got to ask yourself one
# question: Do I feel lucky? Well, do ya, punk?"
use strict;
use warnings;
# [PM] 4.0.2 for some reason diagnostics goes berserk when using PerlApp (ONLYNONWIN32 really means not-using-perlapp)
# [PM] 4.2 diagnostics does not work on Mac OS X 10.6.6. unless XCode (and its docs?) is installed (SPRM 12049)
use diagnostics;                # @ONLYNONWIN32@ @ONLYNONMACOSX@

use Getopt::Long;               # [PM] 4.0.2+

# [PM] The original to the opt_exechome set-up is in spld.pl.in. Keep in synch!
############################
## BEGIN opt_exechome set-up

# [PM] 3.9.1
use FindBin;

use File::Spec;

# [PM] On Win32 this should work at least as well as the old code (since $0 is absolute in PerlApp)
#      On UNIX this should work whenever FindBin works, i.e., unless
#      user invokes this script in some funny way.

my $opt_exechome = $FindBin::Bin;
## [PM] 3.9.2b2 SPRM 3631
##            We need short path so that $SICSTUS need not be quoted.
##            This in turn is because of the totally brain damaged way
##            that cmd.exe (and thus the perl builtin system())
##            treats double quotes
## PLFRM $opt_exechome = Win32::GetShortPathName($opt_exechome);                               

## END opt_exechome set-up
##########################

# Keep in synch with spld.pl.in!
# [PM] 3.9 The following line (the magic marker) marks the place where
# the spld.config variables should be inserted. Only variables
# actually used are inserted and they all get an initial value "". The
# reason for this is to avoid warning about spld.config variables that
# only occur once in this script. This also makes any remaining
# varnings more likely to be significant.
# @ [PM] 4.0.2+ no longer used MAGIC_SPLD_CONFIG_MARKER@

#
# Much code in here is copied from spld.pl.in, Keep in sync!
#

#### START of option variables
## Keep option variables common with spld.pl.in first. Keep in sync!

my $opt_help=0;
my $opt_verbose=0;
my $opt_version=0;
my $opt_output="";              # [PM] 3.9.1 was 0 leading --output=bar.dll giving /OUT:0bar.dll instead of /OUT:bar.dll
my @cflags = ();
my $opt_config="";
my $opt_sicstus="";
my $opt_moveable=0;
my $opt_keep=0;
my $opt_static=0;
my $opt_nocompile=0;               # [PM] do not compile/link just generate code
my $opt_embed_manifest=0;          # [PM] 4.0 embed VC8 manifest
my $opt_no_embed_manifest=0;       # [PM] 4.0 embed VC8 manifest
my $opt_multi_sp_aware=0;          # [PM] 3.9 compile with -DMULTI_SP_AWARE
my $opt_namebase="";               # [PM] 3.9

# [PM] --with-<package> gone in splfr
# $opt_with_jdk="";
# $opt_with_tcltk="";
# $opt_with_tcl="";
# $opt_with_tk="";
# $opt_with_bdb="";

## [PM] 3.9b5 *not* in spld_prefix.pl. The platform of a binary
## installation is decided at build-time (at SICS) not at install-time
## (at customer).
my $opt_platform="x86_64-linux-glibc2.12";
my $config_file_basename="spconfig-4.3.0";
my $release_year="2014"; # [PM] 3.11.2
my $SICSTUS_VERSION="40300";

# my $opt_LD=0;                   # should be removed when $use_getopt is permanented

## things not in common with spld.pl.in

my $opt_structs=0;
my $opt_objects=0;
my $imports="";
my $opt_manual=0;
my $opt_no_rpath=0;
my $namebase_no_s="";              # [PM] 3.9
my $opt_header="";                 # [PM] 3.9 name of header (will be kept if specified even if not --keep)
my $opt_resource="";
my $opt_source="";
my $def_resource="";
my $def_source="";

my $opt_hide_symbols=0;
my $opt_no_hide_symbols=0;

#### END of option variables


my @ldinputs = ();
my @csrcfiles = ();             # C/C++-src to compile
my @objfiles = ();              # files to send to the linker
my @ldrpath = ();               # [PM] 3.9.1 rpath elements

my @tmpfiles = ();              # Temporary files to delete when done


#### START Option processing. Much copied from spld.pl.in  Keep in sync!

my %config;                     # [PM] 4.0.2+ contents of config file

if (@ARGV <= 0) {
  print STDERR "! no arguments.";
  usage();
  exit 1;
}

# my $use_getopt = 1;
# 
# # [PM] 4.0.2+ make it possible to fall back to old behavior
# if ($ARGV[0] eq "--old-getargs") {
#   shift @ARGV;
#   $use_getopt = 0;
# }

### [PM] 4.0.2+ new option processing
my %configs;

# if ($use_getopt)
{

Getopt::Long::Configure("ignore_case",
                        "auto_abbrev",
                        "no_getopt_compat", # do not allow '+' to start options
                        "permute", # allow options to be mixed with other command line arguments
                        "pass_through", # leave unrecognized options-like arguments on @ARGV
                        "no_ignore_case",
                        # auto_version, auto_help does not seem to be supported in the Perl we use on Win32
                        # "no_auto_version", # do not handle --version specially
                        # "no_auto_help", # do not handle --help specially
                        "prefix_pattern=--|-"
                        # , "debug"
                       );
my @nonoptions = ();
my %opt_conf;

# FIXME: beware of old option processing that used previously set option values (e.g. objext).

GetOptions("<>" => sub { push @nonoptions, @_ }, # Why does not $_ work?
## Keep options common with spld.pl.in first. Keep in synch.
           "help|?" => \$opt_help,
           "verbose|v+" => \$opt_verbose, # multiple --verbose accumulates
           "vv" => sub { $opt_verbose = 2 }, # no need to use $opt_vv
           "version" => \$opt_version,

# FIXME: Use '!' argument specification for no{-} -processing?
           "multi-sp-aware" => \$opt_multi_sp_aware,
           "output|o=s" => \$opt_output,
           "namebase=s" => \$opt_namebase,
# FIXME: Use '!' argument specification for no{-} -processing?
           "nocompile" => \$opt_nocompile,
           "static|S" => \$opt_static,
           "sicstus=s" => \$opt_sicstus,
           "moveable" => \$opt_moveable,
           "cflag=s" => \@cflags,
           "config=s" => \$opt_config,
           "keep" => \$opt_keep,
           "exechome=s" => \$opt_exechome,
           # FIXME Document --LD, -LD and --
           # [PM] 3.9.1 this is not treated so well in splfr and is not documented (similar to XPG -- flag)
           "LD" => sub { die("!FINISH") }, # !FINISH is handled specially (stop option processing, like '--'.)
           "conf=s" => \%opt_conf,  # [PM] 4.0.2+ override config entries

           # ignored but parsed
           "with-jdk=s" => sub {},
           "with-tcl=s" => sub {},
           "with-tk=s" => sub {},
           "with-tcltk=s" => sub {},
           "with-bdb=s" => sub {},

## Options specific to splfr.pl.in

           "header=s" => \$opt_header,
           "resource=s" => \$opt_resource,
           "source=s" => \$opt_source,

           "manual" => \$opt_manual,
           "no-rpath" => \$opt_no_rpath,
           "structs" => \$opt_structs,
           "objects" => \$opt_objects,

# FIXME: Use '!' argument specification for no{-} -processing?
           "embed-manifest" => \$opt_embed_manifest,   # [PM] 4.0
           "no-embed-manifest" => \$opt_no_embed_manifest, # [PM] 4.0

# FIXME: Use '!' argument specification for no{-} -processing?
           "hide-symbols" => \$opt_hide_symbols,     # [PM] 3.9.1 this is the default, use mapfile etc to hide all but the main fun
            # [PM] 3.9.1 Do not attempt to hide any symbols. This is
            # a fallback if there are unanticipated problems with the
            # hiding done by default. This option is not expected to
            # be useful.
           "no-hide-symbols" => \$opt_no_hide_symbols
          ) ||
  ( usage(), exit 1 );

&verbose("\@ARGV is (" . join("|", @ARGV) . ")\n");

## Some early options

# [PM] 3.11.3 SPRM 8062 FindBin.pm 1.44 returns path with terminating slash
$opt_exechome =~ s,(.*)/$,$1,;  # remove last slash, if any, unless root dir

# Uses $opt_config and $opt_exechome
&read_config();                 # read config file into %configs

# [PM] 4.0.2+ Process any config file overrides
foreach (keys (%opt_conf)) {
  if (defined $configs{$_}) {
    verbose("Overriding config option $_=" . $opt_conf{$_} . "\n");
    $configs{$_} = $opt_conf{$_};
  } else {
    die("! Unknown configure option: $_.");
  }
}
## option aliases

# [PM] 3.9.1 $opt_moveable is the same as $opt_no_rpath.
$opt_no_rpath=1 if ($opt_moveable);
$opt_moveable=1 if ($opt_no_rpath);
$opt_hide_symbols = 1 if (! $opt_no_hide_symbols);
vverbose("\$opt_hide_symbols=$opt_hide_symbols, \$opt_no_hide_symbols=$opt_no_hide_symbols\n");

# Option canonicalization
# FIXME: any other option that should be canonicalized?
if ($configs{"SPLIT_OPT_CFLAG"}) {
  @cflags = grep { $_ ne '' } split(/,/,join(',',@cflags)); # also remove empty elements!
}

verbose("\@nonoptions is (" . join("|", @nonoptions) . ")\n");
foreach (@nonoptions) {
  &param_sub($_);
}

# Note spld.pl.in uses @linkfiles
push @ldinputs, @ARGV;        # add any remaining arguments last on linkfiles
}                               # $use_getopt

#### END Option processing.

## [PM] 3.9.1 the original to verbose and vverbose is in spld.pl.in keep in synch!
sub verbose {
    if ($opt_verbose >= 1) {
	print STDERR "@_";
    }
}

sub vverbose {
    if ($opt_verbose >= 2) {
	print STDERR "@_";
    }
}

sub debugprint {
    if ($opt_verbose >= 3) {
	print STDERR "@_";
    }
}

sub iswin32 {
    if ($opt_platform =~ m/win32/) {
	return 1;
    } else {
	return 0;
    }
}

sub basename {
    my $suffix = $_[1];
    if ($suffix) {
	$_[0] =~ m,([^/]*)\Q$suffix\E$,s;
	return $1;
    } else {
	$_[0] =~ m,([^/]*)$,s;
	return $1;
    }
}

# not used in splfr
# sub dirname {
#   $_[0] =~ m,^(.*)/([^/]*)$,s;
#   return $1;
# }

# From Perl Cookbook
sub trim {
    my @out = @_;
    for (@out) {
	s/^\s+//;
	s/\s+$//;
	s/\s+/ /g;
    }
    return wantarray ? @out : $out[0];
}

# [PM] 4.0.2 ensure we always clean up.
END {
  # Delete temporary files unless --keep has been given
  if (@tmpfiles) {
    if ($opt_keep) {
      verbose("% Keeping temporary files: @tmpfiles\n");
    } else {
      verbose("% Removing temporary files: @tmpfiles\n");
      unlink @tmpfiles;
    }
  }
}

# !! Original is in spld.pl.in. Keep in synch!
# Parse the configuration file spld.config (which is generated
# by configure).
# The configuration file is matched using the following regexp:
# Assignment = ^(\w+)\s*=(.*)$
# Where $1 is the variable name and $2 is the value to assign
# to it.
sub parse_config
{
  open CONF, "$opt_config" or
    die("! Could not open configuration file $opt_config: $!\n");
  verbose("% Reading configuration file \"$opt_config\"\n");
  while (<CONF>) {
    if (/^(\w+)\s*=(.*)$/) {
      $configs{$1} = $2;
#      $pname = $1;
#      $$pname = $2;
    }
  }
  close CONF;
}

# !! Original is in spld.pl.in. Keep in synch!
sub read_config
{
  # [PM] 3.8.5 sprm1678 Do not relocate according to exechome if
  #      --config is explicitly specified 
  # Also used in splfr.pl.in. Keep in synch!
  if (!$opt_config) {
    if ($opt_exechome) {
      my $fname;
      # [PM] 3.9.1b4 name changes are passed from configure instead (For movability).
      # # Make sure to catch any name changes of the configuration
      # # file, it is currently version-suffixed.
      # $fname = &basename($opt_config);
      $fname = $config_file_basename;
      $opt_config="$opt_exechome" . "/$fname";
    } else {
      $opt_config=$opt_config_default;
    }
  }
  parse_config();
}

sub optdebug {
#   print STDERR @_;
}

# A similar function exists in spld.pl.in, keep in sync!
# param_sub() is called for each non-option argument.
# Such argument are handled as follows:
# .o, .obj -> object-files
# .c, .cc, .C, .cxx, .cpp -> C/C++ source-code
# default -> sent to the linker
sub param_sub
{
  $_ = $_[0];

  verbose("% Handling non-option arg $_");

  if (/\.(o|obj)$/) {
    verbose(" ... as object file\n");
    push @objfiles, $_;
  } elsif (/\.(c|cc|C|cxx|cpp)$/) {
    verbose(" ... as C/C++ source file\n");
    push @csrcfiles, $_;
    # [PM] 4.0.2+ This would try to delete ../foo.o, given ../foo.c even though we will create ./foo.o.
    # # [PM] 3.9.2b2 do not keep the object file
    # push @tmpfiles, "$`." . $configs{"OBJEXT"}; # $` is "the string preceeding the last successful match"
  } elsif (m@((.*)/)?(.*?)\.((pro)|(pl))$@) {
    verbose(" ... as Prolog source file\n");
    $def_source = $_;
    $def_resource = $3;         # [PM] 3.9 ought to be based on opt_source if present!?
  } else {
    verbose(" ... as linker input\n");
    push @ldinputs, $_;
  }
}

# The original is in spld.pl.in. Keep in synch!
my $opt_exechome_parent;
# set $opt_exechome_parent
# [PM] 3.9.1 by now $opt_exechome has been set-up (from default or from --exechome=<DIR>)
{
  # there has got to be a simpler way of removing the last directory component!?
  my @dirs;
  my ($volume,$exechomedirs,$exechomefile);
  # [PM] 4.0.2+ done above
  # # [PM] 3.11.3 SPRM 8062 FindBin.pm 1.44 returns path with terminating slash
  # # Note: this will incorrectly blame FindBin if --exechome was passed
  # # a slash-terminated path. No big deal, removing the slash is OK anyway.
  # if ($opt_exechome =~ m,.+/$,) { # exechome ends in slash but is not root dir
  #   vverbose("Broken Perl module FindBin, FindBin::Bin ends in slash (\"$opt_exechome\")\n");
  #   vverbose("  Applying workaround to broken Perl module FindBin\n");
  #   $opt_exechome =~ s,/$,,;       # remove last slash
  #   vverbose("  New result == \"$opt_exechome\"\n");
  # }

  if (File::Spec->can('splitdir')) {
    vverbose("Can File::Spec->splitdir(\"$opt_exechome\")\n");
    # [PM] 3.9.1 contrary to the perldoc.com docs splitdir is *not*
    # available in Perl 5.005_03 (the version of Perl we have on
    # rs6000-aix-4.3 (AIX 4.3.3)
    if (&iswin32()) {           # [PM] 3.9.1 win32 implies File::Spec->can('splitpath')
      vverbose("Can File::Spec->splitpath(\"$opt_exechome\")");
      ($volume,$exechomedirs,$exechomefile) = File::Spec->splitpath($opt_exechome,1);
      vverbose("== (\"" . ($volume ? $volume : "") . "\",\"${exechomedirs}\",\"" . $exechomefile . "\")\n");
    } else {
      # vverbose("Cannot File::Spec->splitpath(\"$opt_exechome\")\n");
      undef($volume);
      $exechomefile = "";
      $exechomedirs = $opt_exechome;
    }
    @dirs = File::Spec->splitdir($exechomedirs);
  } else {
    # [PM] 4.1.3 Can this happen anymore (used to be an issue on some legacy platforms)
    my $tmp = $opt_exechome;
    # undef($volume);
    # $exechomefile = "";

    vverbose("Cannot File::Spec->splitdir(\"$opt_exechome\") fallback to split(...)\n");
    # [PM] 3.9.1 do not remove initial / (this matches the behaviour of splitdir)
    # $tmp =~ s@^/@@;    # remove initial /
    @dirs = split(m@/@, $tmp);
  }
  # [PM] 3.9.1 here @dirs looks like ("" "usr" "local" "bin" ) NOTE the initial empty component

  pop @dirs;
  # [PM] 3.9.1 here @dirs looks like ("" "usr" "local" )

  vverbose("\@dirs==@dirs\n");

  my $opt_exechome_parent_dir;
  if (File::Spec->can('catdir')) {
    vverbose("Can File::Spec->catdir(@dirs)");
    $opt_exechome_parent_dir = File::Spec->catdir(@dirs);
    vverbose("==\"$opt_exechome_parent_dir\"\n");
  } else {                      # File::Spec missing on really old perl (5.004_04) used on IRIX 6.5
    vverbose("Cannot File::Spec->catdir(@dirs), fallback to join()");
    $opt_exechome_parent_dir = join("/",@dirs);
    vverbose("==\"$opt_exechome_parent_dir\"\n");
  }
  if (&iswin32()) {             # Win32 implies File::Spec->can('catpath')
    vverbose("Can File::Spec->catpath($volume, $opt_exechome_parent_dir, \"\")");
    $opt_exechome_parent = File::Spec->catpath($volume, $opt_exechome_parent_dir, "");
    vverbose("==\"$opt_exechome_parent\"\n");
  } else {
    $opt_exechome_parent = $opt_exechome_parent_dir;
  }
  vverbose("\$opt_exechome_parent==\"$opt_exechome_parent\"\n");
}

if ($opt_nocompile) {
  $opt_keep = 1;
}

# Similar in spld.pl.in. Keep in synch!
sub version {
# [PM] 4.3 Keep the first line of --version synced between all tools
    print <<EOF;
splfr (SICStus Prolog $configs{"SICSTUS_VERSION_STRING"})

SICStus Prolog Release $configs{"SICSTUS_VERSION_STRING"}
Copyright (c) 1998-$release_year SICS Swedish ICT

Report bugs at:

    http://www.sics.se/sicstus/bugreport/bugreport.html
EOF

    exit 0 if ($opt_version);
}

# A similar function exists in spld.pl.in, keep in sync!
sub usage
{
  print <<EOF;

Usage: splfr [options] files...

    -?|--help                   Prints a summary of all options.
    --version                   Prints the version of splfr.
    -v,--verbose                Be verbose. Multiple occurrences increase verbosity.
    --namebase=<Base>           Name base for generated source. Default <Res>.
    --nocompile                 Generate files but do not compile anything.
                                Implies --keep.
                                Mostly useful for generating the header file.
    -o,--output=<File>          Specify output file name. The use of this option
                                is discouraged.
    --resource=<Res>            Specify resource name. Default <Src>.
    --source=<Src>              Specify (Prolog) source file.
    --header=<Header>           Specify name of generated C header corresponding
                                to foreign declarations.
                                Default name is <NAMEBASE>_glue.h.
    --manual                    Do not generate glue code.
    -S,--static                 Create a statically linked foreign resource.
    --multi-sp-aware            Create a (dynamic) foreign resource that can be
                                loaded by several SICStus run-times in the same
                                process, at the same time. See the manual.
    --sicstus=<Exec>            Specify an alternate SICStus executable.
    --moveable                  Do not hardcode any paths into the foreign resource.
                                By default, on platforms that support it, each <dir>
                                specified with -L<dir> is added to the "RPATH" of
                                dynamic foreign resources.

    --keep                      Do not erase temporary files and glue code.
    --structs                   Prolog source file uses library(structs).
    --objects                   Prolog source file uses library(objects).
    --cflag=<Option>            Option to send to compiler.
                                Multiple occurences accumulates.
                                If <Option> contain commas then each comma-separated part is treated
                                as a separate compiler option. This may change in the future,
                                instead you should use multiple occurences of --cflag.
    --config=<File>             Specify an alternate configuration file.
    --conf OPT=VAL              Override configuration file value of option OPT.
                                Can occur multiple times.
    --                          Stop parsing options and tread the rest of the arguments as
                                non-option arguments.


    --no-rpath                  See the manual.
    --exechome=<DIR>            Undocumented
    --hide-symbols              Undocumented. This is the default.
    --no-hide-symbols           Undocumented
    --embed-manifest            Undocumented
    --no-embed-manifest         Undocumented


Legacy options:

    -LD                         Same as --
    --vv                        Same as -v -v
    --with-<package>=<DIR>      Ignored, for backward compatibility.

For a more detailed explanation of these options, consult the online
manual:

    http://www.sics.se/sicstus/docs/

Report bugs at:

    http://www.sics.se/sicstus/bugreport/bugreport.html

EOF

  # [PM] 4.0.2+ Caller should exit 0 or exit 1 as needed
  #    exit 0;
}

if ($opt_help) {
  usage();
  exit 0;
}

if ($opt_version || $opt_verbose) {
  version();
}

# Original of this code in spld.pl.in, keep in synch!
# [PM] 3.9.2 if running as a cygwin perl script we need to convert back to POSIX path from Win32 paths in some cases.
sub nativepath {
  my $orig_path = $_[0];
  vverbose("nativepath(\"$orig_path\") ->");

  if (($orig_path ne "") && &iswin32() && ($^O eq "cygwin")) {
    $orig_path=`cygpath -w "$orig_path"`;
    $orig_path =~ s@\\@/@g;
    # [PM] 3.9.2 for some reason there will be a terminating newline remove it
    chomp $orig_path;
  }
  vverbose(" \"$orig_path\"\n");
  return $orig_path;
}

# Original of this code in spld.pl.in, keep in synch!
my ($prefix, $native_prefix);
my ($SP_BINAUXDIR, $SP_BINAUXDIR_NATIVE);
my $SP_LIBDIR;
my $SP_ROOTLIBDIR;
my ($tmpfilebase_c, $tmpfilebase_h);
my ($tmpfile_c, $tmpfile_h);
# [PM] 3.9.1 set-up paths
{
  if (&iswin32()) {
    # [PM] 3.9b4 these are where spld/splfr can find files at compile/link time

    # [PM] 3.9.1
    $prefix = $opt_exechome_parent;
    # [PM] pre 3.9.1
    # $prefix="$opt_exechome";
    # $prefix =~ s@(.*)[/\\][^/\\]*?$@$1@; # Strip last component of path

    # Duplicated in splfr.pl.in KEEP IN SYNCH
    # [PM] 3.9.2 when running as a script under cygwin we need a native path for CL.EXE
    $native_prefix = &nativepath($prefix);

    $SP_BINAUXDIR="$prefix/bin";
    $SP_BINAUXDIR_NATIVE="$native_prefix/bin";

    $SP_LIBDIR="$prefix";
    $SP_ROOTLIBDIR="$prefix/bin";
  } else {
    # [PM] 3.9.1 note that these lib/ are not related to the value of $configs{"SP_RTSYS_DIRNAME"}/
    # [PM] 3.9b4 these are where spld can find files at compile/link time
    if ($opt_exechome) {        # [PM] 3.9.1 now on UNIX as well
      vverbose("\$opt_exechome_parent = \"$opt_exechome_parent\", \$DEF_PREFIX = \"" . $configs{"DEF_PREFIX"} . "\"\n");
      $prefix = $opt_exechome_parent;
      vverbose("Setting prefix using $opt_exechome/.. to \"$prefix\"\n");
    } else {                    # fall back, should not happen
      verbose("ERROR: could not set \$opt_exechome, fallback to \$DEF_PREFIX \"" . $configs{"DEF_PREFIX"} . "\"\n");
      $prefix=$configs{"DEF_PREFIX"};
    }
    $native_prefix=$prefix;
    $SP_BINAUXDIR="$prefix/lib/" . $configs{"SP_DIRNAME"} . "/bin";
    $SP_BINAUXDIR_NATIVE=$SP_BINAUXDIR;
    $SP_LIBDIR="$prefix/lib/" . $configs{"SP_DIRNAME"};
    $SP_ROOTLIBDIR="$prefix/lib"; # $SP_RT_DIR
  }
}                               # end of shared code

my $SP_BINDIR="$prefix/bin";
my $SP_INCDIR="$native_prefix/include";

# [PM] 3.9.2b2 on UNIX we have version suffixed exes, use these to
# permit multiple versions of sicstus to be installed in the same bin
# directory.
my $SICSTUS_VERSION_EXE_SUFFIX;
if (&iswin32()) {
  $SICSTUS_VERSION_EXE_SUFFIX = "";
} else {
  $SICSTUS_VERSION_EXE_SUFFIX = "-" . $configs{"SICSTUS_VERSION_STRING"};
}

my $SICSTUS;
if ($opt_sicstus ne "") {
  $SICSTUS=$opt_sicstus;
} else {
  $SICSTUS="$SP_BINDIR/sicstus$SICSTUS_VERSION_EXE_SUFFIX";
}

if (&iswin32() && ($^O ne "cygwin")) {
    # Replace '/' with '\' on Windows, since system() does not
    # accept '/' in commands when piping stuff to them.
    $SICSTUS =~ s@/@\\@g;
}

my $SICSTUS_FLAGS = "-f";
# [PM] 3.12.2 inhibit both logo and "loading ..." messages unless verbose
if (!$opt_verbose) {
  $SICSTUS_FLAGS .= " --nologo --noinfo";
}

$opt_namebase = trim($opt_namebase); # needed?


# [PM] 4.1.3+ real-ld and GCC_B_DIR is gone
# # [PM] 3.9.1 dir where gcc can find our real-ld wrapper
# my $GCC_B_DIR=$SP_BINAUXDIR;

my $QC=$configs{"QUOTECHAR"};

# For some strange reason, a leading space sometimes appears
# in $opt_resource. --Jojo
$opt_resource = trim($opt_resource);
$opt_header = trim($opt_header); # needed?


my $keep_header = 0;
if ($opt_header ne "") {
  $keep_header = 1;
}

if ($opt_resource eq "") {
    if ($def_resource eq "") {
	die "! No resource name specified. Exiting.\n";
    } else {
	$opt_resource=$def_resource;
    }
}
if (&iswin32()) {
  # [PM] 3.9b4 PRM 2903 use lowercase resname on windows since that is
  # the only possible input to load_foreign_resource.
  $opt_resource = lc($opt_resource);
}

if (not $opt_manual) {
    if ($opt_source eq "") {
	if ($def_source eq "") {
	    die "! No source file specified. Exiting.\n";
	} else {
	    $opt_source=$def_source;
	}
    }
    $namebase_no_s = $opt_namebase; # [PM] used for header (random_glue.h should not change name if --static)
    if ($opt_keep) {
      if ($opt_namebase eq "") {
        $namebase_no_s = $opt_resource;
        if ($opt_static) {      # static foreign resource
          # Was _S but on win32 this becomes _s due to SICStus lowercasing of pathnames
          # Better to have it _s on all platforms
          $opt_namebase=$namebase_no_s . "_s"; # prevent clashing with dynamic version when --keep.
        } else {                # dynamic
          $opt_namebase=$namebase_no_s;
        }
      }
    }
    # invariant: if $opt_namebase is non-empty then so is $namebase_no_s
    if ($opt_namebase ne "") {
      $tmpfilebase_c= $opt_namebase . "_glue";
      # $tmpfilebase_h= $tmpfilebase_c;
      $tmpfilebase_h= $namebase_no_s . "_glue";
    } else {                    # $opt_namebase = ""
      $tmpfilebase_c= sprintf("%s_glue_%d_%d", $opt_resource, $$, time()); # $$ is Process ID
      if ($keep_header || 1) {  # [PM] 3.9b5 always generate header with a predictable name
        $tmpfilebase_h = sprintf("%s_glue", $opt_resource); # kludge
      } else {
        $tmpfilebase_h= $tmpfilebase_c;
      }
    }
    $tmpfile_c= $tmpfilebase_c . ".c";
    if ($opt_header ne "") {
       $tmpfile_h= $opt_header; # not really a tmp-file if opt_header specified
     } else {
       $tmpfile_h= $tmpfilebase_h . ".h";
     }
    # my $obj= $tmpfilebase_c . "." . $configs{"OBJEXT"};

    $opt_source = trim($opt_source);
    if ($opt_structs) {
	$imports = $imports . ",str_decl";
    }
    if ($opt_objects) {
	$imports = $imports . ",obj_decl";
    }
    if ($imports ne "") {
	$imports = substr($imports,1);
    }
    # [PM] 3.9b5 use --goal to minimize dependency on shell and echo (primarily a problem for Win32)
    my @command = "$SICSTUS $SICSTUS_FLAGS --goal $QC" . "use_module(library(fligen)), splfr_prepare_foreign_resource('$opt_resource','$opt_source','$tmpfile_c','$tmpfile_h', [$imports]).$QC";
    verbose("@command\n");
    my $rc = system("@command");
    if ($rc != 0) {
	die "! Could not generate glue-code (exit code=$rc)\n";
    }
    if (not -e $tmpfile_c) {
	die "! No glue-file generated.\n";
    }
    push @tmpfiles, $tmpfile_c;
    # push @tmpfiles, $obj;
    push @csrcfiles, "$tmpfile_c";
    if ($tmpfile_h ne "") {
      if (!$keep_header) {
        push @tmpfiles, "$tmpfile_h";
      }
      # $gensrc{"$tmpfile_h"} = "$tmpfile_h";
    }
}

sub hexdigit {
  if ($_[0] <= 9) {
    return chr(ord('0')+$_[0]);
  } else {
    return chr(ord('A')+($_[0]-0xA));
  }
}

## [PM] 3.9.1b1 This routine exists in library(resgen) AND Bips/flids.pl AND Emulator/foreign.c AND Utils/splfr.pl.in
##              They *must* produce the same result!
sub sp_ensure_c_name {
    my $orig = $_[0];
    my $remains = $orig;
    my $new = "";
    # verbose("orig = \"$orig\"\n");
    while ($remains =~ /[^0-9a-zA-Z]/) { # [0-9a-zA-Z] (note that 'w' is in a-z in ASCII)
      # verbose("in while postmatch = \"$'\", prematch=\"$`\", hexdigit(ord(\$&) >> 4)=\"" . hexdigit(ord($&) >> 4) . "\", hexdigit(ord(\$&) & 0xF)=\"" . hexdigit(ord($&) & 0xF) . "\"\n");
      $remains = $';
      $new = $new . $` . "_0x" . hexdigit(ord($&) >> 4) . hexdigit(ord($&) & 0xF);
    }
    $new = $new . $remains;
    # verbose("sp_ensure_c_name(\"$orig\")==\"$new\"\n");
    return $new;
}

my $sp_resname=&sp_ensure_c_name($opt_resource);
my $SP_MAIN_PREFIX="sp_main_SPENV_"; # [PM] xref foreign.h

my $sp_main_name="${SP_MAIN_PREFIX}$sp_resname";


push(@cflags, "-DSPDLL " . $configs{"INCR_CFLAGS"}) if (not $opt_static);
push(@cflags, "-DSP_STATIC_FOREIGN_RESOURCE") if ($opt_static);
push(@cflags, "-DMULTI_SP_AWARE") if ($opt_multi_sp_aware);

push(@cflags, "-DSP_RESNAME=$sp_resname"); # see spaux.h.in
push(@cflags, "-DSICSTUS_TARGET_VERSION=$SICSTUS_VERSION"); # [PM] 4.0.5 for consistency check

# [PM] 3.9.1 what used to be called LDFLAGS is now split and renamed
#            FIXME: the renaming shows that these LD flags may not be the right thing here
#            FIXME: Do as spld and pass these explicitly and all libs last
# $ldflags = " $LDFLAGS ";

# [PM] 3.9.1 SPLD_EXE_LDFLAGS replaced by $SPLFR_SHLDFLAGS
#            Pass SPLFR_SHLD_LIBS last for linkers where use of symbols need to preceed def (IRIX 6.5)
#            FIXME: SPLFR_SHLD_LIBS should be its own variable, not SPLD_EXE_LIBS

my $SPLFR_SHLD_LIBS=$configs{"SPLD_EXE_LIBS"};

if (&iswin32()) {
  $SPLFR_SHLD_LIBS =~ s@\\@/@g;
}

my @splfr_shdl_libs = split(' ', $SPLFR_SHLD_LIBS);

vverbose("ldinputs = @ldinputs\n");

if (&iswin32()) {
  # [PM] 3.8.6 quick hack to remove -nologo if verbose. Done right in 3.9 (no)
  if ($opt_verbose) {
    $configs{"CFLAGS"} =~ s/ -nologo //g;
  }
}

# Compile c-code
if (!$opt_nocompile) {
  for my $cfile (@csrcfiles) {
    my $obj = $cfile;
    $obj =~ s/^((.*)[\\\/])*(.*)\.(.*)$/$3.$configs{"OBJEXT"}/;
    push @tmpfiles, $obj;       # [PM] 4.0.2+ cleanup

    ## [PM] 4.3 Need to look for glue.h relative namebase (SPRM 12259)
    my $namebase_dir;

    $_ = $opt_namebase;

    if (m,^(.+)/[^/]*$,) {
       $namebase_dir="$1";
    } else {
       $namebase_dir=".";
    }

    ## [PM] Mar 2000 *first* look in SP_INCDIR so we get the correct version of sicstus.h
    ##      ([PM] have not found any documentation on the significance of -I option order)
    my @command = ($configs{"CC"} . " -I\"$SP_INCDIR\" -I\"$namebase_dir\" " . $configs{"CFLAGS"} . " @cflags " . $configs{"NOLINK_OPT"} . " $cfile " . $configs{"NOLINK_OUTPUT_OPT"} . "$obj");
    verbose("% Compiling $cfile...\n");
    verbose("@command\n");
    my $rc = system("@command");
    if ($rc != 0) {
      die "! Could not compile $cfile\n";
    }
    push @objfiles, $obj;
  }
}

if (not $opt_output) {
    if ($opt_static) {
	$opt_output = $opt_resource . "." . $configs{"STSFX"};
    } else {
	$opt_output = $opt_resource . "." . $configs{"FLI_SHSFX"};
    }
}

$opt_output =~ s@\\@/@g;

# [PM] 3.9.1 FIXME: this should use the same method as spld.pl.in (@ldrpath)
# Add -R flags for each -L encountered in ldinputs
# [PM] 3.8.6 added opt_no_rpath (mainly for libjasper).
if ((not $opt_no_rpath) && not &iswin32()) {
  # [PM] 3.9.1 FIXME should look for entries in @ldinputs that look
  # like LD_ROPT (with or without -Wl, prefix.) This fix is needed
  # in spld.pl.in too.
  for my $flag (@ldinputs) {
    # [PM] 3.9.1 new -R processing, collect all rpath items on @ldrpath
    $_ = $flag;
    if (m/^-L(.*)$/) {
      push @ldrpath, "$1";
    }
  }

  my $rpath="";
  if (@ldrpath) {
    my $delim = "";
    for my $p (@ldrpath) {
      if ($p) {
        $rpath .= $delim . $p;
        $delim = ":";
      }
    }
  }

  if ($configs{"SPLFR_SHLD_ROPT"} && $rpath) {
    vverbose("Adding RPATH \"" . $configs{"SPLFR_SHLD_ROPT"} . "'$rpath'\" to ldinputs\n");
    push @ldinputs, $configs{"SPLFR_SHLD_ROPT"} . "'$rpath'";
  }
}

my $expfile = $tmpfilebase_c . ".exp";
my $mapfile = $tmpfilebase_c . ".mapfile";
my $need_mapfile = 0;
my $need_expfile = 0;

# [PM] 3.9.1 hide all but the setup function, if possible
my $splfr_ld_export = "";
my $splfr_shld_export = "";

if ($opt_hide_symbols) {        # this is the default
  if ($opt_static) {

    $need_expfile = 1 if ($configs{"SPLFR_LD_R_POST_PROCESS"}); # e.g., MacOS X/Darwin

    # Some platforms allow ld -r to hide symbols
    if ($configs{"SPLFR_LD_EXPORT_ARG"} ne "") {
      $splfr_ld_export = $configs{"SPLFR_LD_EXPORT_ARG"};

# [PM] 4.1.3+ real-ld and GCC_B_DIR is gone
#      $splfr_ld_export =~ s/GCC_B_DIR_MARKER/$GCC_B_DIR/g;
      $splfr_ld_export =~ s/\@SP_MAIN_NAME\@/$sp_main_name/g;

      if ($splfr_ld_export =~ s/\@SP_EXPORT_FILE\@/$expfile/g) {
        $need_expfile = 1;
      }

      if ($splfr_ld_export =~ s/\@SP_MAP_FILE\@/$mapfile/g) {
        $need_mapfile = 1;
      }
    }

  } else {                      # !$opt_static

    $need_expfile = 1 if ($configs{"SPLFR_SHLD_POST_PROCESS"}); # e.g., MacOS X/Darwin

    if ($configs{"SPLFR_SHLD_EXPORT_ARG"} ne "") {
      $splfr_shld_export = $configs{"SPLFR_SHLD_EXPORT_ARG"};

# [PM] 4.1.3+ real-ld and GCC_B_DIR is gone
#      $splfr_shld_export =~ s/GCC_B_DIR_MARKER/$GCC_B_DIR/g;
      $splfr_shld_export =~ s/\@SP_MAIN_NAME\@/$sp_main_name/g;

      if ($splfr_shld_export =~ s/\@SP_EXPORT_FILE\@/$expfile/g) {
        $need_expfile = 1;
      }

      if ($splfr_shld_export =~ s/\@SP_MAP_FILE\@/$mapfile/g) {
        $need_mapfile = 1;
      }
    }
  }
}


if ($need_expfile) {
  push @tmpfiles, $expfile;

  verbose("Creating export file $expfile\n");
  
  open(EXPFILE, ">$expfile") or die "! Could not open $expfile: $!\n";
  print EXPFILE $configs{"EXPFILE_SYMBOL_PREFIX"} . $sp_main_name . "\n";
  close(EXPFILE);
}

if ($need_mapfile) {
  # [PM] 4.2 avoid '/' and other illegal map-name characters
  my $mapname = &basename($tmpfilebase_c);
  $mapname =~ s,[^a-zA-Z_],_,g;

  push @tmpfiles, $mapfile;

  verbose("Creating map file $mapfile (mapname $mapname)\n");
  
  open(MAPFILE, ">$mapfile") or die "! Could not open $mapfile: $!\n";
  print MAPFILE "$mapname {\n";
  print MAPFILE "  global:\n";
  print MAPFILE "    $sp_main_name;\n";
  print MAPFILE "  local:\n";
  print MAPFILE "    *;\n";
  print MAPFILE "};\n";
  close(MAPFILE);
}

if ($opt_embed_manifest || $opt_no_embed_manifest) {
  if ($opt_no_embed_manifest)
    {
      $opt_embed_manifest = 0;
    }
} else {                        # no option specified
  if ($configs{"SPLFR_EMBED_MANIFEST"} eq "yes") {
    $opt_embed_manifest = 1;    # [PM] 4.0 default on Win32, we assume Visual Studio 2005
  }
}

{
  verbose("% Building foreign resource \"$opt_resource\"...\n");
  if ($opt_static) {
    if (not &iswin32()) {
      my $command = $configs{"LD"} . " -r " . $configs{"SPLFR_LD_r_FLAGS"} . " $splfr_ld_export @objfiles " . $configs{"OUTPUT_OPT"} . $opt_output;
      if ($opt_nocompile) {
        verbose("Skipping command: $command\n");
      } else {
        verbose("$command\n");
        my $rc = system($command);
        if ($rc != 0) {
          die "! Could not build static resource\n";
        }
      }

      # [PM] 4.0.2+ The export file should already have been created above (if $need_expfile).
      # however, this breaks if --no-hide-symbols since that would prevent expfile from being created.
      # For now we make the assumption that post-processing is only used for symbol-hiding

      if ($configs{"SPLFR_LD_R_POST_PROCESS"}
          && $opt_hide_symbols
          ) {

        # [PM] 3.9.1 Create an export file and apply some kind of stripping
        # Used for MacOS X, most other platforms do this directly with linker args.
        # If we need to post-process for other platforms we may need to generalize

        # [PM] 3.9.1 the expfile is now created above
        # $expfile = $tmpfilebase_c . ".exp";
        # push @tmpfiles, $expfile;
        #
        # open(EXPFILE, ">$expfile") or die "! Could not open $expfile: $!\n";
        # print EXPFILE "${EXPFILE_SYMBOL_PREFIX}$sp_main_name\n";
        # close(EXPFILE);

        my $command = $configs{"SPLFR_LD_R_POST_PROCESS"} . " " . $configs{"SPLFR_LD_R_POST_PROCESS_EXPFILE_OPT"} . $expfile . " " . $configs{"SPLFR_LD_R_POST_PROCESS_LIB_OPT"} . $opt_output;
        if ($opt_nocompile) {
          verbose("Skipping command: $command\n");
        } else {
          verbose("$command\n");
          my $rc = system($command);
          if ($rc != 0) {
            die "! Could not post-process static foreign resource\n";
          }
        }
      }

    } else {                    # Win32
      my $nologo_flags = "";
      if (not $opt_verbose) {
        $nologo_flags = "/nologo"
      }
      # [PM] hard code "lib" is ugly
      my $command = "lib $nologo_flags @objfiles /OUT:$opt_output";
      if ($opt_nocompile) {
        verbose("Skipping command: $command\n");
      } else {
        verbose("$command\n");
        my $rc = system($command);
        if ($rc != 0) {
          die "! Could not build static resource\n";
        }
      }
    }
  } else {                      # ! $opt_static

    my $tmpfilebase_implib = $tmpfilebase_c . "_imp";
    my $splfr_shld_lastarg = $configs{"SPLFR_SHLD_LASTARG"};

    # [PM] 4.0.2+ cannot use a fixed name (dummy.lib, dummy.exp) with parallel make
    $splfr_shld_lastarg =~ s/dummy/$tmpfilebase_implib/g;

    my $command = $configs{"SPLFR_SHLD"} . " " . $configs{"SPLFR_SHLDFLAGS"} . " $splfr_shld_export @objfiles " . $configs{"SHLD_OUTPUT_OPT"} . "$opt_output @ldinputs @splfr_shdl_libs " . $splfr_shld_lastarg;
    if (&iswin32()) {
      # [PM] 3.9.1b4 now on $SPLFR_SHLD_LASTARG
      # $command .= " -IMPLIB:dummy.lib";
      
      

      # [PM] 3.9.1 should match the name of the dummy lib on SPLFR_SHLD_LASTARG
      push @tmpfiles, "$tmpfilebase_implib.lib"; # make sure it is removed later.
      push @tmpfiles, "$tmpfilebase_implib.exp"; # make sure it is removed later.
    }
    if ($opt_nocompile) {
      verbose("Skipping command: $command\n");
    } else {
      verbose("$command\n");
      my $rc = system($command);
      if ($rc != 0) {
        die "! Could not build dynamic foreign resource\n";
      }
    }

    if ($opt_embed_manifest) {
      my $manifest="$opt_output.manifest";

      my $command = $configs{"MT"} . " /manifest $manifest /outputresource:$opt_output;#2";       # 2 is ISOLATIONAWARE_MANIFEST_RESOURCE_ID
      if ($opt_nocompile) {
        verbose("Skipping command: $command\n");
      } else {
        verbose("$command\n");
        my $rc = system($command);
        if ($rc != 0) {
          die "! Could not build dynamic foreign resource\n";
        }
      }
      # Delete the embedded manifest file
      if (!$opt_keep) {         # also implied by $opt_nocompile
        push @tmpfiles, $manifest;
      }
    }

    # [PM] 4.0.2+ The export file should already have been created above (if $need_expfile).
    # however, this breaks if --no-hide-symbols since that would prevent expfile from being created.
    # For now we make the assumption that post-processing is only used for symbol-hiding
    if ($configs{"SPLFR_SHLD_POST_PROCESS"}
        && $opt_hide_symbols
        ) {

        # [PM] 3.9.1 Create an export file and apply some kind of stripping
        # Used for MacOS X, most other platforms do this directly with linker args.
        # If we need to post-process for other platforms we may need to generalize


        # [PM] 4.0.2+ see $need_expfile above
        # $expfile = $tmpfilebase_c . ".exp";
        # push @tmpfiles, $expfile;
        # verbose("Creating $expfile\n");
        # open(EXPFILE, ">$expfile") or die "! Could not open $expfile: $!\n";
        # print EXPFILE $configs{"EXPFILE_SYMBOL_PREFIX"} . $sp_main_name . "\n";
        # close(EXPFILE);

        my $command = $configs{"SPLFR_SHLD_POST_PROCESS"} . " " . $configs{"SPLFR_SHLD_POST_PROCESS_EXPFILE_OPT"} . $expfile . " " . $configs{"SPLFR_SHLD_POST_PROCESS_LIB_OPT"} . $opt_output;
        if ($opt_nocompile) {
            verbose("Skipping command: $command\n");
        } else {
            verbose("$command\n");
            my $rc = system($command);
            if ($rc != 0) {
                die "! Could not post-process dynamic resource\n";
            }
        }
    }
  }                             # ! $opt_static
}

# [PM] 4.0.2+ done in END-block
# # Delete temporary files unless --keep has been given
# if ($opt_keep) {
#     print STDERR "% Keeping temporary files...\n";
# #     for my $src (@tmpfiles) {
# # 	if ($file = $gensrc{$src}) {
# # 	    print STDERR "$src (symbolic name is $file)\n";
# # 	}
# #     }
# } else {
#     verbose("% Removing temporary files: @tmpfiles\n");
#     unlink @tmpfiles;
# }
