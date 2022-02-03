# aegis
Plaintext Encryptin Utility for telehack.com

http://deb10-nyc.underwood.network/~drtac7/aegis.bas

```
AEGIS v1.2.2 Encryption Utility for TELEHACK                   
                                                               
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
        -logo: view AEGIS logo and about screen                
        -license: display license information                  
        -faq: view the frequently asked questions message      
                                                               
Examples:  aegis -es forbin                                    
           aegis -s msg forbin                                 
           aegis -a message underwood                          
           aegis -c file                                       
           aegis -o file   
``` 
           
