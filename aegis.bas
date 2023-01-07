
' MIT License                                               _______________      
'                                                           \......|....../      
' Name:           AEGIS - Plaintext Encryption Utility       \ A E G I S /       
' Copyright:      (c) 2022 telehack.com/u/drtac7              \....|..../        
' Website:        https://www.github.com/DRTAC7/aegis          \...|.../         
' Author:         drtac7                                        \..|../          
' Contributors:   searinox, zcj                                  \.|./           
' License:        MIT                                             \|/            
'                                                                                
' Permission is hereby granted, free of charge, to any person obtaining a copy   
' of this software and associated documentation files (the "Software"), to deal  
' in the Software without restriction, including without limitation the rights   
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      
' copies of the Software, and to permit persons to whom the Software is          
' furnished to do so, subject to the following conditions:                       
'                                                                                
' The above copyright notice and this permission notice shall be included in all 
' copies or substantial portions of the Software.                                
'                                                                                
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
' SOFTWARE.                                                                      
 
' IF YOU WISH TO MAKE OFFICIAL MODIFICATIONS TO THIS SOFTWARE
' PLEASE SEND A MAIL TO DRTAC7 ON TELEHACK
' AND HE WILL ADD YOU TO THE REPO, WHERE YOU CAN CREATE A PULL REQUEST
    
    10  ver$ = "2.0.7"
        goto 110

    30  ?
        ? " FAQ:"
        ? "     FATAL ERROR 01 will occur if:                                                                    "
        ? "         - the encrypted file (.ags, .agsc, .agsk) does not exist                                     "
        ? "         - the encrypted file is blank                                                                "
        ? "         - an error that causes double filetyping (Ex. msg.ags.ags)                                   "
        ? "         - (Most common) you included the filetype (.ags, .agsc, .agsk) when naming or calling a file "
        ? "                                                                                                      "
        ? "     FATAL ERROR 02 will occur if:                                                                    "
        ? "         - you attempt to name the encrypted file '*'                                                 "
        ? "         - you are using a mobile device (may not always occur)                                       "
        
        END

    40  ?
        ? " AEGIS v" ver$ " Encryption Utility for TELEHACK                   "
        ? "                                                                   "
        ? " %usage: aegis <function> [filename] [sender/receipient]           "
        ? "         prefix all functions with -, --, /, or nothing at all     "
        ? "                                                                   "
        ? "         DO NOT INCLUDE THE FILETYPE (.AGS .AGSK .AGSC)            "
        ? "         WHEN NAMING OR CALLING A FILE!                            "
        ? "                                                                   "
        ? " Availble command line functions:                                  "
        ? "          e:   encrypt a message and save to disk                  "
        ? "          s:   send a pre-encrypted file:                          "
        ? "          es:  encrypt a message and send immediately              "
        ? "          d:   decrypt a message stored on the disk                "
        ? "          a:   accept an incoming file and decrypt                 "
        ? "          o:   combine cipher and key file                         "
        ? "          c:   print the raw contents of a .ags file to the screen "
        ? "          l:   list all .ags files present on disk                 "
        ? "          p:   purge all .ags files stored on the disk             "
        ? "          x:   stop all outgoing sends                             "
        ? "          faq: view the frequently asked questions message         "
        ? "                                                                   "
        ? " Examples:  aegis -es forbin                                       "
        ? "            aegis -s msg forbin                                    "
        ? "            aegis -a message underwood                             "
        ? "            aegis -c file                                          "
        ? "            aegis -o file                                          "
        ?
        
        END

    110 ' Generate ASCII Lookup Table for Encoding /// provided by searinox
        counter = 0
        for i = 65 to 90
            tmp$ = str$(counter)
            if len(tmp$) = 1 then tmp$ = "0" + tmp$
            array$(i) = tmp$ : counter = counter + 1
        next
        for i = 97 to 122
            tmp$ = str$(counter)
            array$(i) = tmp$
            counter = counter + 1
        next
        for i = 48 to 57
            tmp$ = str$(counter)
            array$(i) = tmp$
            counter = counter + 1
        next
        array$(43) = "62" ' +
        array$(47) = "63" ' /
        array$(61) = "64" ' =

    115 ' COMMANDS
        argv$(1) = th_sed$( argv$(1), "^(-?-|/)" )
        if th_re( ups$( argv$(1) ), "^(ES|SE)$" ) and argv$(2) <> "" then to$ = argv$(2) : send_now = 1 : goto 190
        if th_re( ups$( argv$(1) ), "^S(END)?$" ) and argv$(2) <> "" and argv$(3) <> "" then to$ = argv$(3) : goto 240
        if th_re( ups$( argv$(1) ), "^E(NCRYPT)?$" ) then goto 190
        if th_re( ups$( argv$(1) ), "^D(ECRYPT)?$" ) and argv$(2) <> "" then ef$ = argv$(2) : goto 142
        if th_re( ups$( argv$(1) ), "^D(ECRYPT)?$" ) then goto 140
        if th_re( ups$( argv$(1) ), "^P(URGE)?$" ) then goto 270
        if th_re( ups$( argv$(1) ), "^A(CCEPT)?$" ) and argv$(2) <> "" and argv$(3) <> "" then goto 210
        if th_re( ups$( argv$(1) ), "^L(IST)?$" ) then goto 230
        if th_re( ups$( argv$(1) ), "^C(ONTENTS)?$" ) and argv$(2) <> "" then goto 220
        if th_re( ups$( argv$(1) ), "^(O|COMBINE)$" ) and argv$(2) <> "" then goto 260
        if th_re( ups$( argv$(1) ), "^(X|CANCEL)$" ) then th_exec "send /attach /stop" : goto 9999
        if th_re( ups$( argv$(1) ), "^(FAQ|HELP|\?)$" ) then goto 30
        goto 40

    120 ' ENCODE
        for e = 1 to len(emsg$)
            e$ = mid$(emsg$, e, 1)
            index$ = index$ + array$(asc(e$))
        next

    130 ' ENCRYPT
        for o = 1 to len(index$)
            o$ = mid$(index$, o, 1)
            key$ = str$(nint(rnd(9)))
            otp$ = otp$ + key$
            num% = val(o$) - val(key$)
            if num% < 0 then num% = num% + 10    
            encryptedmsg$ = encryptedmsg$ + str$(num%)    
        next
        return

    140 ' DECRYPT

        ' READ DATA FROM FILE AND PUT IT IN CULL$
        141 ? : input "Filename: ", ef$
        142 if ef$ = "" or ef$ = spc$(len(ef$)) then ? "%error - blank filename" : goto 141
            open ef$ + ".ags", as #1
        143 if typ(1) = 3 then goto 144
            input# 1, cull$
            goto 143
        144 close #1

    150 ' SPLIT THE DATA INTO MSG AND KEY
            if cull$ = "" then ? "FATAL ERROR 01: Type 'aegis -faq' for details" : goto 9999
            readmsg$ = ""
        151 m$ = mid$(cull$, m, 1) : ' FATAL ERROR 01: Type 'aegis -faq' for details
            if m$ = " " then m$ = "" : goto 152
            if m$ = "l" then m$ = "" : k$ = "" : m = m + 1 : goto 153
            readmsg$ = readmsg$ + m$
        152 m = m + 1
            goto 151
        153 readkey$ = ""
            k = m
        154 k$ = mid$(cull$, k, 1)
            if k$ = " " then k$ = "" : k = k + 1 : goto 160
            readkey$ = readkey$ + k$
            k = k + 1
            goto 154

    160 ' APPLY MATHS FUNCTIONS TO DECRYPT HASH TO INDEX65
        for V% = 1 to len(readmsg$)
            rm$ = mid$(readmsg$, V%, 1)
            rk$ = mid$(readkey$, V%, 1)
            if V% = len(readkey$) + 1 then goto 161
            dnum% = val(rm$) + val(rk$)
            if dnum% >= 10 then dnum% = dnum% - 10
            dnum$ = dnum$ + str$(dnum%)
        next
    161 dindex$ = dnum$

    170 ' DECODE
        for t = 1 to len(dindex$)
            first$ = mid$(dindex$, t, 1)
            second$ = mid$(dindex$, t + 1, 1)
            both$ = first$ + second$

            ' UPPERCASE
            if both$ = "00" then t = t + 1 : db64$ = db64$ + ups$("A")
            if both$ = "01" then t = t + 1 : db64$ = db64$ + ups$("B")
            if both$ = "02" then t = t + 1 : db64$ = db64$ + ups$("C")
            if both$ = "03" then t = t + 1 : db64$ = db64$ + ups$("D")
            if both$ = "04" then t = t + 1 : db64$ = db64$ + ups$("E")
            if both$ = "05" then t = t + 1 : db64$ = db64$ + ups$("F")
            if both$ = "06" then t = t + 1 : db64$ = db64$ + ups$("G")
            if both$ = "07" then t = t + 1 : db64$ = db64$ + ups$("H")
            if both$ = "08" then t = t + 1 : db64$ = db64$ + ups$("I")
            if both$ = "09" then t = t + 1 : db64$ = db64$ + ups$("J")
            if both$ = "10" then t = t + 1 : db64$ = db64$ + ups$("K")
            if both$ = "11" then t = t + 1 : db64$ = db64$ + ups$("L")
            if both$ = "12" then t = t + 1 : db64$ = db64$ + ups$("M")
            if both$ = "13" then t = t + 1 : db64$ = db64$ + ups$("N")
            if both$ = "14" then t = t + 1 : db64$ = db64$ + ups$("O")
            if both$ = "15" then t = t + 1 : db64$ = db64$ + ups$("P")
            if both$ = "16" then t = t + 1 : db64$ = db64$ + ups$("Q")
            if both$ = "17" then t = t + 1 : db64$ = db64$ + ups$("R")
            if both$ = "18" then t = t + 1 : db64$ = db64$ + ups$("S")
            if both$ = "19" then t = t + 1 : db64$ = db64$ + ups$("T")
            if both$ = "20" then t = t + 1 : db64$ = db64$ + ups$("U")
            if both$ = "21" then t = t + 1 : db64$ = db64$ + ups$("V")
            if both$ = "22" then t = t + 1 : db64$ = db64$ + ups$("W")
            if both$ = "23" then t = t + 1 : db64$ = db64$ + ups$("X")
            if both$ = "24" then t = t + 1 : db64$ = db64$ + ups$("Y")
            if both$ = "25" then t = t + 1 : db64$ = db64$ + ups$("Z")

            ' LOWERCASE
            if both$ = "26" then t = t + 1 : db64$ = db64$ + "a"
            if both$ = "27" then t = t + 1 : db64$ = db64$ + "b"
            if both$ = "28" then t = t + 1 : db64$ = db64$ + "c"
            if both$ = "29" then t = t + 1 : db64$ = db64$ + "d"
            if both$ = "30" then t = t + 1 : db64$ = db64$ + "e"
            if both$ = "31" then t = t + 1 : db64$ = db64$ + "f"
            if both$ = "32" then t = t + 1 : db64$ = db64$ + "g"
            if both$ = "33" then t = t + 1 : db64$ = db64$ + "h"
            if both$ = "34" then t = t + 1 : db64$ = db64$ + "i"
            if both$ = "35" then t = t + 1 : db64$ = db64$ + "j"
            if both$ = "36" then t = t + 1 : db64$ = db64$ + "k"
            if both$ = "37" then t = t + 1 : db64$ = db64$ + "l"
            if both$ = "38" then t = t + 1 : db64$ = db64$ + "m"
            if both$ = "39" then t = t + 1 : db64$ = db64$ + "n"
            if both$ = "40" then t = t + 1 : db64$ = db64$ + "o"
            if both$ = "41" then t = t + 1 : db64$ = db64$ + "p"
            if both$ = "42" then t = t + 1 : db64$ = db64$ + "q"
            if both$ = "43" then t = t + 1 : db64$ = db64$ + "r"
            if both$ = "44" then t = t + 1 : db64$ = db64$ + "s"
            if both$ = "45" then t = t + 1 : db64$ = db64$ + "t"
            if both$ = "46" then t = t + 1 : db64$ = db64$ + "u"
            if both$ = "47" then t = t + 1 : db64$ = db64$ + "v"
            if both$ = "48" then t = t + 1 : db64$ = db64$ + "w"
            if both$ = "49" then t = t + 1 : db64$ = db64$ + "x"
            if both$ = "50" then t = t + 1 : db64$ = db64$ + "y"
            if both$ = "51" then t = t + 1 : db64$ = db64$ + "z"

            ' NUMBERS
            if both$ = "52" then t = t + 1 : db64$ = db64$ + "0"
            if both$ = "53" then t = t + 1 : db64$ = db64$ + "1"
            if both$ = "54" then t = t + 1 : db64$ = db64$ + "2"
            if both$ = "55" then t = t + 1 : db64$ = db64$ + "3"
            if both$ = "56" then t = t + 1 : db64$ = db64$ + "4"
            if both$ = "57" then t = t + 1 : db64$ = db64$ + "5"
            if both$ = "58" then t = t + 1 : db64$ = db64$ + "6"
            if both$ = "59" then t = t + 1 : db64$ = db64$ + "7"
            if both$ = "60" then t = t + 1 : db64$ = db64$ + "8"
            if both$ = "61" then t = t + 1 : db64$ = db64$ + "9"        

            ' SPECIAL CHARACTERS
            if both$ = "62" then t = t + 1 : db64$ = db64$ + "+"
            if both$ = "63" then t = t + 1 : db64$ = db64$ + "/"
            if both$ = "64" then t = t + 1 : db64$ = db64$ + "="
        next

    180 ' CONVERT Base64 to Plaintext
        ? : ? "Decrypted Message: " + th_b64d$(db64$)
        ?
        sleep 0.5 : th_exec "rm " + ef$ + ".ags" ' scratch ef$ + ".ags" ; out$
        goto 9999

    190 ' MESSAGE INPUT AND CONCEALMENT FUNCTIONS
            ?
        191 msg$ = "" : ? "Message: " ;
        192 hide$ = inkey$ : if hide$ = chr$(13) then goto 193
            if (hide$ = chr$(127) or hide$ = chr$(8)) and len(msg$) > 0 then msg$ = left$( msg$, abs( len( msg$ )-1 ) ) : ? chr$(8) + " " + chr$(8) ;
            if hide$ = chr$(127) or hide$ = chr$(8) then goto 192
            msg$ = msg$ + hide$ : ? "*" ;
            goto 192
            ? : if len(msg$) < 1 then goto 191
        193 file$ = "" : ? : ? "Filename: " ;
        194 hides$ = inkey$ : if hides$ = chr$(13) then goto 195
            if (hides$ = chr$(127) or hides$ = chr$(8)) and len(file$) > 0 then file$ = left$( file$, abs( len( file$ )-1 ) ) : ? chr$(8) + " " + chr$(8) ;
            if hides$ = chr$(127) or hides$ = chr$(8) then goto 194
            file$ = file$ + hides$ : ? "*" ;
            goto 194
        195 if len(file$) < 1 then goto 193
            if len(file$) > 3 then ? : ? "Filename must not exceed 3 characters" : goto 193
            emsg$ = th_b64e$(msg$)
            gosub 120

    200 ' FILE OUTPUT FUNCTIONS
            if ups$( argv$(1) ) <> "E" then goto 201
            ? : ? "Save cipher and key separately? (y/N)" ;
            keychoice$ = inkey$
            if keychoice$ = "y" then goto 250
        201 open file$ + ".ags", as #1 : ' FATAL ERROR 02: type 'aegis -faq' for details
            ?# 1, encryptedmsg$ + "l" + otp$ + " "
            close #1
            ? : th_exec "ls " + file$ + ".ags"
            if send_now then now$ = "y" : goto 203
            ? "Send now? [y/N] " ; : now$ = inkey$ : ? now$ : if now$ = "y" then goto 202
            goto 9999
        202 input "To: ", to$ : if to$ = user$ then ? "You cannot send a file to yourself! Select another user." : goto 202
        203 if to$ = user$ then ? "You cannot send a file to yourself! Select another user." : goto 202
        204 th_exec "send /attach=" + file$ + ".ags " + to$
            ? "[R]esend if the file transfer fails." : ? "[D]elete file, cancel send, and close program." :  ? "^C to close. Request to send will persist." : if inkey$ <> "d" then goto 204
            th_exec "send /attach /stop"
            scratch file$ + ".ags" ; out$
            ? "Message File Deleted"
            goto 9999

    210 ' ACCEPT and DECRYPT
        th_exec "send /accept=" + argv$(2) + ".ags " + argv$(3)
        ef$ = argv$(2)
        goto 142
    
    220 ' ? THE CONTENTS OF A .AGS FILE
        ? "--- Embedded ---" : ? : th_exec "cat " + argv$(2) + ".ags" : ?
        ? "--- Cipher ---" : ? : th_exec "cat " + argv$(2) + ".agsc" : ?
        ? "--- Key ---" : ? : th_exec "cat " + argv$(2) + ".agsk" : ?
        goto 9999

    230 ' LIST ALL .AGS FILES
         no_files$ = "%glob: file not found"
         ? "--- Embedded files ---" : ? : th_exec "ls *.ags" ; out$ : ? th_sed$(out$, no_files$, "?no aegis files found")
         ? "--- Cipher files ---" : ? : th_exec "ls *.agsc" ; out$ : ? th_sed$(out$, no_files$, "?no aegis files found")
         ? "--- Key files --- " : ? : th_exec "ls *.agsk" ; out$ : ? th_sed$(out$, no_files$, "?no aegis files found")
         goto 9999

    240 ' SEND PRE-ENCRYPTED FILE
            if argv$(3) = user$ then ? "You cannot send a file to yourself! Select another user." : goto 9999
        241 th_exec "send /attach=" + argv$(2) + ".ags" + " " +  argv$(3)
            ? "[R]esend if the file transfer fails." : ? "[D]elete file and close program." : ? "^C to terminate without deleting" : if inkey$ <> "d" then goto 241
            scratch argv$(2) + ".ags" ; out$
            ? "Message File Deleted"
            goto 9999     
    
    250 ' SAVE CIPHER AND KEY SEPARATELY
         open file$ + ".agsc", as #1
         ?# 1, encryptedmsg$
         close #1
         ? : th_exec "ls " + file$ + ".agsc"
         open file$ + ".agsk", as #1
         ?# 1, otp$
         close #1
         th_exec "ls " + file$ + ".agsk"
         goto 9999

    260 ' FILE COMBINATION
             open argv$(2) + ".agsc", as #1
         261 if typ(1) = 3 then goto 262
             input# 1, cipher$
             goto 261
         262 close #1
             open argv$(2) + ".agsk", as #1
         263 if typ(1) = 3 then goto 264
             input# 1, otpkey$
             goto 263
         264 close #1
             open argv$(2) + ".ags", as #1
             ?# 1, cipher$ + "l" + otpkey$ + " "
             close #1
             ? "Files combined as: " : th_exec "ls " + argv$(2) + ".ags"     
             goto 9999

    270 ' PURGE
             ext$ = ".ags" : gosub 271
             ext$ = ".agsc" : gosub 271
             ext$ = ".agsk" : gosub 271
             goto 9999
         271 th_exec "ls *" + ext$ ; out$
             if th_re( out$, "%glob" ) then ? " no " ext$ " files found" : return
             th_exec "rm *" + ext$
             return

9999 ? "Terminating AEGIS" : END
