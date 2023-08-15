#!/usr/bin/perl

# MIT License                                               _______________      
#                                                           \......|....../      
# Name:           AEGIS - Plaintext Encryption Utility       \ A E G I S /       
# Copyright:      (c) 2023 telehack.com/u/drtac7              \....|..../        
# Website:        https://www.github.com/DRTAC7/aegis          \...|.../         
# Author:         drtac7                                        \..|../          
# Contributors:   ChatGPT                                        \.|./           
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

# Create a mapping of Base64 characters to Index65 values
my @base64_chars = split //, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
my %base64_to_index65;
for my $i (0..$#base64_chars) {
    $base64_to_index65{$base64_chars[$i]} = sprintf("%02d", $i);
}

# Create a mapping of Index65 values to Base64 characters
my %index65_to_base64;
for my $i (0..$#base64_chars) {
    $index65_to_base64{sprintf("%02d", $i)} = $base64_chars[$i];
}

sub encrypt_index65 {
    my ($index65_str) = @_;
    my $encrypted_index65 = '';
    my $key = '';

    for my $digit (split //, $index65_str) {
        my $random_number = int(rand(10));
        my $encrypted_digit = ($digit + $random_number) % 10;
        $encrypted_index65 .= $encrypted_digit;
        $key .= $random_number;
    }

    return ($encrypted_index65, $key);
}

sub decrypt_index65_with_key {
    my ($encrypted_index65, $key) = @_;
    my $decrypted_index65 = '';

    for (my $i = 0; $i < length($encrypted_index65); $i++) {
        my $encrypted_digit = substr($encrypted_index65, $i, 1);
        my $key_digit = substr($key, $i % length($key), 1);
        my $decrypted_digit = ($encrypted_digit - $key_digit + 10) % 10;
        $decrypted_index65 .= $decrypted_digit;
    }

    return $decrypted_index65;
}

sub encrypt_message {
    # Take input from the user
    print "Enter a message to encrypt: ";
    my $input = <STDIN>;
    chomp $input;

    # Convert the input to Index65
    my $index65_string = '';
    for my $char (split //, encode_base64($input)) {
        if (exists $base64_to_index65{$char}) {
            $index65_string .= $base64_to_index65{$char};
        }
    }

    # Encrypt the Index65 string
    my ($encrypted_msg, $key) = encrypt_index65($index65_string);

    print "Original Message: $input\n";
    print "Encrypted Message: $encrypted_msg\n";
    print "Key: $key\n";

    exit; # Terminate the program after encryption
}

sub decrypt_message {
    # Take input from the user
    print "Enter an encrypted message: ";
    my $encrypted_input = <STDIN>;
    chomp $encrypted_input;

    # Take input from the user
    print "Enter the key: ";
    my $key = <STDIN>;
    chomp $key;

    # Decrypt the encrypted message
    my $decrypted_index65 = decrypt_index65_with_key($encrypted_input, $key);

    my $base64_output = '';
    for (my $i = 0; $i < length($decrypted_index65); $i += 2) {
        my $index = substr($decrypted_index65, $i, 2);
        if (exists $index65_to_base64{$index}) {
            $base64_output .= $index65_to_base64{$index};
        }
    }

    my $decoded_output = decode_base64($base64_output);

    print "Encrypted Message: $encrypted_input\n";
    print "Decrypted Message: $decoded_output\n";

    exit; # Terminate the program after decryption
}

print "Choose an option:\n";
print "1. Encrypt a message\n";
print "2. Decrypt a message\n";
print "Option: ";

my $option = <STDIN>;
chomp $option;

if ($option == 1) {
    encrypt_message();
} elsif ($option == 2) {
    decrypt_message();
} else {
    print "Invalid option\n";
    exit; # Terminate the program if an invalid option is selected
}
