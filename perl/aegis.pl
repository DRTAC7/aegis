#!/usr/bin/env perl

# MIT License                                               _______________      
#                                                           \......|....../      
# Name:           AEGIS - Plaintext Encryption Utility       \ A E G I S /       
# Copyright:      (c) 2023 telehack.com/u/drtac7              \....|..../        
# Website:        https://www.github.com/DRTAC7/aegis          \...|.../         
# Authors:        drtac7                                        \..|../          
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

# compatibility with <5.18 perls
use English qw( -no_match_vars );

# Create a mapping of Base64 characters to Index65 values
my @base64_chars = ('A'..'Z', 'a'..'z', 0..9, '+', '/', '=');
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
    # Take input from the user
    print "Enter a message to encrypt and save to a file: ";
    chomp (my $input = <STDIN>);

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

    # Create the encrypted message with key string
    my $encrypted_string = "$encrypted_msg" . "l" . "$key";

    # Prompt the user for a filename
    print "Enter the filename (without extension): ";
    chomp (my $filename = <STDIN>);

    # Write the encrypted message to a .agsp file
    open(my $file, '>', "$filename.agsp") or die "Cannot open file '$filename.agsp' for writing: $!";
    print $file $encrypted_string;
    close($file);

    print "File '$filename.agsp' created.\n";
    exit; # Terminate the program after creating the file
}

sub decrypt_file 
{
    # Take input from the user
    print "Enter the filename (without extension) of the .agsp file to decrypt: ";
    chomp (my $filename = <STDIN>);

    # Read the content of the .agsp file
    open(my $file, '<', "$filename.agsp") or die "Cannot open file '$filename.agsp' for reading: $!";
    my $content = <$file>;
    close($file);

    # Separate the encrypted message and key using 'l'
    my ($encrypted_msg, $key) = split 'l', $content;

    # Decrypt the encrypted message
    my $decrypted_index65 = decrypt_index65_with_key($encrypted_msg, $key);

    my $base64_output = '';
    for (my $i = 0; $i < length($decrypted_index65); $i += 2) 
    {
        my $index = substr($decrypted_index65, $i, 2);
        if (exists $index65_to_base64{$index}) 
        {
            $base64_output .= $index65_to_base64{$index};
        }
    }

    my $decoded_output = decode_base64($base64_output);

    print "\nDecrypted Message: $decoded_output\n\n";

    exit; # Terminate the program after decryption
}

sub delete_agsp_files 
{
    # Get a list of .agsp files in the current directory
    my @agsp_files = glob("*.agsp");

    if (@agsp_files) 
    {
        foreach my $agsp_file (@agsp_files) 
        {
            unlink $agsp_file or warn "Could not delete $agsp_file: $!";
        }
        print scalar(@agsp_files) . "\n .agsp files deleted.\n\n";
    } else {
        print "No .agsp files found in the directory.\n";
    }

    exit; # Terminate the program after deleting .agsp files
}

print "Choose an option:\n";
print "1. Encrypt a message\n";
print "2. Decrypt a message\n";
print "3. Create a file with encrypted message and key\n";
print "4. Decrypt a file\n";
print "5. Delete all .agsp files in the directory\n";
print "0. Exit\n";
print "Option: ";

chomp (my $option = <STDIN>);

if ($option == 1) # Encrypt a message
{
    print "Enter a message to encrypt: ";
    chomp (my $input = <STDIN>);
    my $index65_string = '';
    for my $char (split //, encode_base64($input)) 
    {
        if (exists $base64_to_index65{$char}) 
        {
            $index65_string .= $base64_to_index65{$char};
        }
    }
    my ($encrypted_msg, $key) = encrypt_index65($index65_string);
    print "\nEncrypted Message: $encrypted_msg\n";
    print "\nKey: $key\n\n";
} elsif ($option == 2) # Decrypt a message
{
    print "Enter the encrypted message: ";
    chomp (my $encrypted_msg = <STDIN>);
    print "Enter the key: ";
    chomp (my $key = <STDIN>);
    my $decrypted_index65 = decrypt_index65_with_key($encrypted_msg, $key);
    my $base64_output = '';
    for (my $i = 0; $i < length($decrypted_index65); $i += 2) 
    {
        my $index = substr($decrypted_index65, $i, 2);
        if (exists $index65_to_base64{$index}) 
        {
            $base64_output .= $index65_to_base64{$index};
        }
    }
    my $decoded_output = decode_base64($base64_output);
    print "\nDecrypted Message: $decoded_output\n\n";
} elsif ($option == 3) { # Create an encrypted file
    create_file();
} elsif ($option == 4) { # Decrypt an encrypted file
    decrypt_file();
} elsif ($option == 5) { # Delete all .agsp files
    delete_agsp_files();
} elsif ($option == 0) { # Exit cleanly
    print "\nTerminating...\n\n";
    exit;
} else {
    print "Invalid option\n";
    exit; # Terminate the program if an invalid option is selected
}
