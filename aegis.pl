#!/usr/bin/env perl

# MIT License                                               _______________
#                                                           \......|....../
# Name:           AEGIS - Plaintext Encryption Utility       \ A E G I S /
# Copyright:      (c) 2023 telehack.com/u/drtac7              \....|..../
# Website:        https://www.github.com/DRTAC7/aegis          \...|.../
# Author:         drtac7                                        \..|../
# Contributors:   zcj, ChatGPT                                   \.|./
# License:        MIT                                             \|/
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# IF YOU WISH TO MAKE OFFICIAL MODIFICATIONS TO THIS SOFTWARE
# PLEASE SEND A MAIL TO DRTAC7 ON TELEHACK
# AND HE WILL ADD YOU TO THE REPO, WHERE YOU CAN CREATE A PULL REQUEST

use strict;
use warnings;
use MIME::Base64;
use File::Glob;

# Version Number
my $ver = "3.3.1";

# compatibility with <5.18 perls
use English qw( -no_match_vars );

# Create a mapping of Base64 characters to Index65 values
my @base64_chars = ('A'..'Z', 'a'..'z', 0..9, '+', '/', '=',);
my %base64_to_index65;
for my $i (0..$#base64_chars)
{
    $base64_to_index65{$base64_chars[$i]} = sprintf("%02d", $i);
}

# Create a mapping of Index65 values to Base64 characters
my %index65_to_base64;
for my $i (0..$#base64_chars)
{
    $index65_to_base64{sprintf("%02d", $i)} = $base64_chars[$i];
}

sub encrypt_index65
{
    my ($index65_str) = @_;
    my $encrypted_index65 = '';
    my $key = '';

    for my $digit (split //, $index65_str)
    {
        my $random_number = int(rand(10));
        my $encrypted_digit = ($digit + $random_number) % 10;
        $encrypted_index65 .= $encrypted_digit;
        $key .= $random_number;
    }

    return ($encrypted_index65, $key);
}

sub decrypt_index65_with_key
{
    my ($index65_str, $key) = @_;
    my $decrypted_index65 = '';

    my @index65_digits = split //, $index65_str;
    my @key_digits = split //, $key;

    for my $i (0..$#index65_digits)
    {
        my $decrypted_digit = ($index65_digits[$i] - $key_digits[$i] + 10) % 10;
        $decrypted_index65 .= $decrypted_digit;
    }

    return $decrypted_index65;
}

sub create_file
{
    my ($input, $filename, $save_separate) = @_;

    # Convert the input to Index65
    my $index65_string = '';
    for my $char (split //, encode_base64($input))
    {
        if (exists $base64_to_index65{$char})
        {
            $index65_string .= $base64_to_index65{$char};
        }
    }

    # Encrypt the Index65 string
    my ($encrypted_msg, $key) = encrypt_index65($index65_string);

    if ($save_separate) {
        open(my $msg_file, '>', "$filename.agspc") or die "Cannot open file '$filename.agspc' for writing: $!";
        print $msg_file $encrypted_msg;
        close($msg_file);

        open(my $key_file, '>', "$filename.agspk") or die "Cannot open file '$filename.agspk' for writing: $!";
        print $key_file $key;
        close($key_file);

        print "Encrypted message saved in '$filename.agspc' and key saved in '$filename.agspk'.\n";
    } else {
        my $encrypted_string = "$encrypted_msg" . "l" . "$key";

        open(my $file, '>', "$filename.agsp") or die "Cannot open file '$filename.agsp' for writing: $!";
        print $file $encrypted_string;
        close($file);

        print "File '$filename.agsp' created.\n";
    }
}


sub decrypt_file
{
    my ($agsp_filename, $output_filename) = @_;

    open(my $agsp_file, '<', "$agsp_filename.agsp") or die "Cannot open file '$agsp_filename.agsp' for reading: $!";
    my $encrypted_string = <$agsp_file>;
    close($agsp_file);

    my ($encrypted_msg, $key) = split('l', $encrypted_string);

    my $decrypted_index65 = decrypt_index65_with_key($encrypted_msg, $key);

    my $decrypted_base64 = '';
    for my $digit (unpack("(A2)*", $decrypted_index65))
    {
        $decrypted_base64 .= $index65_to_base64{$digit};
    }

    my $decrypted_message = decode_base64($decrypted_base64);

    if ($output_filename) {
        open(my $output_file, '>', "$output_filename") or die "Cannot open file '$output_filename' for writing: $!";
        print $output_file $decrypted_message;
        close($output_file);

        print "Decrypted message saved in '$output_filename'.\n";
    } else {
        print "\nDecrypted Message: $decrypted_message\n\n";
    }
}

sub encrypt_txt_to_agsp
{
    my ($txt_path, $agsp_filename, $save_separate) = @_;

    open(my $txt_file, '<', $txt_path) or die "Cannot open file '$txt_path' for reading: $!";
    my $content = do { local $/; <$txt_file> };
    close($txt_file);

    my $index65_string = '';
    for my $char (split //, encode_base64($content))
    {
        if (exists $base64_to_index65{$char})
        {
            $index65_string .= $base64_to_index65{$char};
        }
    }

    # Encrypt the Index65 string
    my ($encrypted_msg, $key) = encrypt_index65($index65_string);

    if ($save_separate) {
        open(my $msg_file, '>', "$agsp_filename.agspc") or die "Cannot open file '$agsp_filename.agspc' for writing: $!";
        print $msg_file $encrypted_msg;
        close($msg_file);

        open(my $key_file, '>', "$agsp_filename.agspk") or die "Cannot open file '$agsp_filename.agspk' for writing: $!";
        print $key_file $key;
        close($key_file);

        print "Encrypted message saved in '$agsp_filename.agspc' and key saved in '$agsp_filename.agspk'.\n";
    } else {
        my $encrypted_string = "$encrypted_msg" . "l" . "$key";

        open(my $agsp_file, '>', "$agsp_filename.agsp") or die "Cannot open file '$agsp_filename.agsp' for writing: $!";
        print $agsp_file $encrypted_string;
        close($agsp_file);

        print "File '$agsp_filename.agsp' created.\n";
    }
}

sub split_agsp_file
{
    my ($agsp_filename) = @_;

    open(my $agsp_file, '<', "$agsp_filename.agsp") or die "Cannot open file '$agsp_filename.agsp' for reading: $!";
    my $encrypted_string = <$agsp_file>;
    close($agsp_file);

    my ($encrypted_msg, $key) = split('l', $encrypted_string);

    open(my $msg_file, '>', "$agsp_filename.agspc") or die "Cannot open file '$agsp_filename.agspc' for writing: $!";
    print $msg_file $encrypted_msg;
    close($msg_file);

    open(my $key_file, '>', "$agsp_filename.agspk") or die "Cannot open file '$agsp_filename.agspk' for writing: $!";
    print $key_file $key;
    close($key_file);

    print "Split .agsp file into '$agsp_filename.agspk' and '$agsp_filename.agspc'.\n";
}

sub delete_agsp_files
{
    my @agsp_files = glob("*.agsp *.agspk *.agspc");

    if (@agsp_files)
    {
        foreach my $agsp_file (@agsp_files)
        {
            unlink $agsp_file or warn "Could not delete $agsp_file: $!";
        }
        print scalar(@agsp_files) . " files deleted.\n";
    } else {
        print "No .agsp, .agspk, or .agspc files found in the directory.\n";
    }
}

sub combine_agsp_files
{
    my ($combined_filename) = @_;

    my $agspc_filename = "${combined_filename}.agspc";
    my $agspk_filename = "${combined_filename}.agspk";

    open(my $agspc_file, '<', $agspc_filename) or die "Cannot open file '$agspc_filename' for reading: $!";
    my $encrypted_msg = <$agspc_file>;
    close($agspc_file);

    open(my $agspk_file, '<', $agspk_filename) or die "Cannot open file '$agspk_filename' for reading: $!";
    my $key = <$agspk_file>;
    close($agspk_file);

    my $encrypted_string = "${encrypted_msg}l${key}";

    open(my $combined_file, '>', "${combined_filename}.agsp") or die "Cannot open file '${combined_filename}.agsp' for writing: $!";
    print $combined_file $encrypted_string;
    close($combined_file);

    unlink $agspc_filename, $agspk_filename or warn "Could not delete .agspc or .agspk file: $!";
    
    print "Combined .agsp file '${combined_filename}.agsp' created and .agspc/.agspk files deleted.\n";
}

sub print_usage
{
    print "\nAEGIS $ver Encryption Utility for Perl\n\n";
    print "Usage:\n";
    print "$0 e(ncrypt) <output filename> [save separate (y/n)]\n";
    print "$0 d(ecrypt) <input filename> [output filename]\n";
    print "$0 ef <extant filename> <output filename> [save separate (y/n)]\n";
    print "$0 s(plit) <input filename>\n";
    print "$0 c(ombine) <filename>\n";
    print "$0 p(urge)\n\n";
}

if (@ARGV < 1) {
    print_usage();
    exit 1;
}

my $command = shift @ARGV;

if ($command eq "e" || $command eq "encrypt") {
    if (@ARGV < 1 || @ARGV > 2) {
        print_usage();
        exit 1;
    }
    my ($filename, $save_separate) = @ARGV;

    if (!defined $save_separate) {
        $save_separate = 'n';
    }

    print "Message: ";
    chomp(my $input = <STDIN>);
    create_file($input, $filename, lc($save_separate) eq 'y');
} elsif ($command eq "d" || $command eq "decrypt") {
    if (@ARGV < 1 || @ARGV > 2) {
        print_usage();
        exit 1;
    }
    my ($filename, $output_filename) = @ARGV;
    decrypt_file($filename, $output_filename);
} elsif ($command eq "ef") {
    if (@ARGV < 2 || @ARGV > 3) {
        print_usage();
        exit 1;
    }
    my ($txt_path, $agsp_filename, $save_separate) = @ARGV;

    # If the save_separate option is not provided, default to 'n'
    if (!defined $save_separate) {
        $save_separate = 'n';
    }

    if (lc($save_separate) eq 'y') {
        encrypt_txt_to_agsp($txt_path, $agsp_filename);
    } else {
        print "Message: ";
        chomp(my $input = <STDIN>);
        create_file($input, $agsp_filename, lc($save_separate) eq 'y');
    }
} elsif ($command eq "s" || $command eq "split") {
    if (@ARGV != 1) {
        print_usage();
        exit 1;
    }
    my ($agsp_filename) = @ARGV;
    split_agsp_file($agsp_filename);
} elsif ($command eq "p" || $command eq "purge") {
    delete_agsp_files();
} elsif ($command eq "c" || $command eq "combine") {
    if (@ARGV != 1) {
        print_usage();
        exit 1;
    }
    my ($combined_filename) = @ARGV;
    combine_agsp_files($combined_filename);
} elsif ($command eq "--help" || $command eq "-?") {
    print_usage();
} else {
    print "Invalid command: $command\n";
    exit 1;
}
