# AEGIS

![TeleBASIC](https://raw.githubusercontent.com/telehack-foundation/.github/main/profile/svg/telebasic.svg)
![Perl](https://img.shields.io/badge/perl-%2339457E.svg?style=for-the-badge&logo=perl&logoColor=white)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


Plaintext Encryption Utility for Telehack.com

***AEGIS May be obtained from the following sources:***

1. `pub /get drtac7/aegis.bas` (requires a user account on [Telehack](https://www.telehack.com))
    - The original version of AEGIS, available only on Telehack.com

2. `git clone https://www.github.com/drtac7/aegis`
   - Includes a version written in Perl that contains the ability to convert an extant .txt file to an encrypted .ags file

```
 AEGIS v3.0 Encryption Utility for TELEHACK                   

 Usage:   aegis <function> [filename] [recipient]                 

          Prefix all functions with -, --, /, or nothing at all    
                                                                   
          DO NOT INCLUDE THE FILETYPE (.AGS .AGSK .AGSC)           
          WHEN NAMING OR CALLING A FILE!                           

 Commands:                                                         

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

 Examples:                                                         

          aegis -es forbin                                         
          aegis -s msg forbin                                      
          aegis -a message underwood                               
          aegis -c file                                            
          aegis -o file                   
```
```
AEGIS 3.3 Encryption Utility for Perl

Usage:
aegis.pl e(ncrypt) <output filename> [save separate (y/n)]
aegis.pl d(ecrypt) <input filename> [output filename]
aegis.pl ef <extant filename> <output filename> [save separate (y/n)]
aegis.pl s(plit) <input filename>
aegis.pl c(ombine) <filename>
aegis.pl p(urge)
```
![Telehack](https://telehack.com/telehack.svg)
![Telehack](https://telehack.com/cmd.svg)
