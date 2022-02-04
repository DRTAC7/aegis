# AEGIS
Plaintext Encryption Utility for telehack.com

***AEGIS May be obtained from the following sources:***

1. `pub /get drtac7/aegis.bas` (requires a user account on https://www.telehack.com)
    - AEGIS runs only on telehack. Running the command above is the most direct way to access AEGIS. 

2. https://www.telehack.com/u/drtac7
   - I also keep an updated copy of AEGIS here

3. This repo. 
   - exists solely for publicity and for contributors to further improve AEGIS over time.

```
AEGIS v" + ver$ + " Encryption Utility for TELEHACK            
                                                             
%usage: aegis <-function> [filename] [sender/receipient]       
        prefix all functions with -                            
                                                             
        DO NOT INCLUDE THE FILETYPE (.AGS .AGSK .AGSC)         
        WHEN NAMING OR CALLING A FILE!                         
                                                             
Availble command line functions:                               
        -e: encrypt a message and save to disk                 
        -s: send a pre-encrypted file:                         
        -es: encrypt a message and send immediately            
        -d: decrypt a message stored on the disk               
        -a: accept an incoming file and decrypt                
        -o: combine cipher and key file                        
        -c: print the raw contents of a .ags file to the screen
        -l: list all .ags files present on disk                
        -p: purge all .ags files stored on the disk            
        -x: stop all outgoing sends                            
        -logo: view AEGIS logo and about screen                
        -license: display license information                  
        -faq: view the frequently asked questions message      
                                                             
Examples:  aegis -es forbin                                    
           aegis -s msg forbin                                 
           aegis -a message underwood                          
           aegis -c file                                       
           aegis -o file                                       
  
           
