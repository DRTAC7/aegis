# AEGIS
![TeleBASIC](https://raw.githubusercontent.com/telehack-foundation/.github/main/profile/svg/telebasic.svg)
![Perl](https://img.shields.io/badge/perl-%2339457E.svg?style=for-the-badge&logo=perl&logoColor=white)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Plaintext Encryption Utility for Telehack.com

***AEGIS May be obtained from the following sources:***

1. `pub /get drtac7/aegis.bas` (requires a user account on [Telehack](https://www.telehack.com))
    - AEGIS runs only on Telehack. Running the command above within Telehack is the most direct way to access AEGIS. 

2. This repo. 
   - exists solely for publicity and for contributors to further improve AEGIS over time.

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
  
           
