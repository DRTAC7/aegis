# AEGIS

![TeleBASIC](https://raw.githubusercontent.com/telehack-foundation/.github/main/profile/svg/telebasic.svg)
![Perl](https://img.shields.io/badge/perl-%2339457E.svg?style=for-the-badge&logo=perl&logoColor=white)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


Plaintext Encryption Utility for Telehack.com

***AEGIS May be obtained from the following sources:***

1. `pub /get drtac7/aegis.bas` (requires a user account on [Telehack](https://www.telehack.com))
    - The original version of AEGIS, available only on Telehack.com

2. `git clone https://www.github.com/drtac7/aegis`
   - Includes a version written in Perl that contains features not present in the Telehack version

```
 AEGIS 2.2 Encryption Utility for TELEHACK             
                                                                 
 %usage: aegis <function> [filename] [sender/recipient]        
         prefix all functions with -, --, /, or nothing at all.           
                                                                 
         DO NOT INCLUDE THE FILETYPE (.AGS .AGSK .AGSC)          
         WHEN NAMING OR CALLING A FILE!                          
                                                                 
 Available command line functions:                                
          e:   encrypt a message and save to disk                  
          s:   send a pre-encrypted file:                          
          es:  encrypt a message and send immediately             
          d:   decrypt a message stored on the disk                
          a:   accept an incoming file and decrypt                 
          o:   combine cipher and key file                         
          c:   print the raw contents of a .ags file to the screen 
          l:   list all .ags files present on disk                 
          p:   purge all .ags files stored on the disk             
          x:   stop all outgoing sends                             
          faq: view the frequently asked questions message       
                                                                 
 Examples:  aegis -es forbin                                     
            aegis -s msg forbin                                  
            aegis -a message underwood                           
            aegis -c file                                        
            aegis -o file     
```
```
AEGIS Version 2.0 for Perl

Choose an option:

1. Create a file with encrypted message and key
2. Decrypt a file and print message to screen
3. Encrypt an existing .txt file into .agsp
4. Decrypt an existing .agsp file and output message to .txt file
5. Delete all .agsp files in the directory
0. Exit

Option:
```
![Telehack](https://telehack.com/telehack.svg)
![Telehack](https://telehack.com/cmd.svg)
