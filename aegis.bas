   10  ver$ = "1.2.5"
   20  goto 890
   30  '
   40  ?
   50  ? " MIT License                                                                          "
   60  ? "                                                                                      "
   70  ? " Name:           AEGIS - Plaintext Encryption Utility                                 "
   80  ? " Copyright:      (c) 2022 telehack.com/u/drtac7                                       "
   90  ? " Author:         drtac7                                                               "
  100  ? " License:        MIT                                                                  "
  110  ? "                                                                                      "
  120  ? " Permission is hereby granted, free of charge, to any person obtaining                "
  130  ? " a copy of this software and associated documentation files (the 'Software'),         "
  140  ? " to deal in the Software without restriction, including without limitation            "
  150  ? " the rights to use, copy, modify, merge, publish, distribute, sublicense,             "
  160  ? " and/or sell copies of the Software, and to permit persons to whom the Software       "
  170  ? " is furnished to do so, subject to the following conditions:                          "
  180  ? "                                                                                      "
  190  ? " The above copyright notice and this permission notice                                "
  200  ? " shall be included in all copies or substantial portions of the Software.             "
  210  ? "                                                                                      "
  220  ? " THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,  "
  230  ? " INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A        "
  240  ? " PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT   "
  250  ? " HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF "
  260  ? " CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE "
  270  ? " OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                        "
  280  '
  290  END
  300  '
  310  ?
  320  ? " FAQ:"
  330  ? "     FATAL ERROR 01 will occur if:                                                                    "
  340  ? "         - the encrypted file (.ags, .agsc, .agsk) does not exist                                     "
  350  ? "         - the encrypted file is blank                                                                "
  360  ? "         - an error that causes double filetyping (Ex. msg.ags.ags)                                   "
  370  ? "         - (Most common) you included the filetype (.ags, .agsc, .agsk) when naming or calling a file "
  380  ? "                                                                                                      "
  390  ? "     FATAL ERROR 02 will occur if:                                                                    "
  400  ? "         - you attempt to name the encrypted file '*'                                                 "
  410  ? "         - you are using a mobile device (may not always occur)                                       "
  420  END
  430  ?
  440  ? " AEGIS v" + ver$ + " Encryption Utility for TELEHACK             "
  450  ? "                                                                 "
  460  ? " %usage: aegis <-function> [filename] [sender/receipient]        "
  470  ? "         prefix all functions with -                             "
  480  ? "                                                                 "
  490  ? "         DO NOT INCLUDE THE FILETYPE (.AGS .AGSK .AGSC)          "
  500  ? "         WHEN NAMING OR CALLING A FILE!                          "
  510  ? "                                                                 "
  520  ? " Availble command line functions:                                "
  530  ? "         -e: encrypt a message and save to disk                  "
  540  ? "         -s: send a pre-encrypted file:                          "
  550  ? "         -es: encrypt a message and send immediately             "
  560  ? "         -d: decrypt a message stored on the disk                "
  570  ? "         -a: accept an incoming file and decrypt                 "
  580  ? "         -o: combine cipher and key file                         "
  590  ? "         -c: print the raw contents of a .ags file to the screen "
  600  ? "         -l: list all .ags files present on disk                 "
  610  ? "         -p: purge all .ags files stored on the disk             "
  615  ? "         -x: stop all outgoing sends                             "
  620  ? "         -logo: view AEGIS logo and about screen                 "
  630  ? "         -license: display license information                   "
  640  ? "         -faq: view the frequently asked questions message       "
  650  ? "                                                                 "
  660  ? " Examples:  aegis -es forbin                                     "
  670  ? "            aegis -s msg forbin                                  "
  680  ? "            aegis -a message underwood                           "
  690  ? "            aegis -c file                                        "
  700  ? "            aegis -o file                                        "
  710  ?
  720  END
  730  '
  740  ?
  750  ?"/*"
  760  ?" * $ID: AEGIS v" + ver$ + " x4052 Wed Jun 16 09:34:32 CST 2021 drtac7 $"
  770  ?" */"
  780  ?"     _______________"
  790  ?"     \......|....../"
  800  ?"      \ A E G I S /"
  810  ?"       \....|..../"
  820  ?"        \...|.../"
  830  ?"         \..|../"
  840  ?"          \.|./"
  850  ?"           \|/"
  860  ?
  870  END
  880  '
  890  ' *** Generate ASCII Lookup Table for Encoding *** /// provided by searinox
  900  counter = 0
  910  for i = 65 to 90
  920  tmp$ = str$(counter)
  930  if len(tmp$) = 1 then tmp$ = "0" + tmp$
  940  array$(i) = tmp$ : counter = counter + 1
  950  next i
  960  for i = 97 to 122
  970  tmp$ = str$(counter) : array$(i) = tmp$ : counter = counter + 1
  980  next i
  990  for i = 48 to 57
 1000  tmp$ = str$(counter) : array$(i) = tmp$ : counter = counter + 1
 1010  next i
 1020  array$(43) = "62" rem +
 1030  array$(47) = "63" rem /
 1040  array$(61) = "64" rem =
 1050  ' *** COMMANDS ***
 1060  if argv$(1) = "-es" and argv$(2) <> "" then to$ = argv$(2) : goto 1210
 1070  if argv$(1) = "-s" and argv$(2) <> "" and argv$(3) <> "" then to$ = argv$(3) : goto 2910
 1080  if argv$(1) = "-e" then goto 1210
 1090  if argv$(1) = "-d" and argv$(2) <> "" then ef$ = argv$(2) : goto 1750
 1100  if argv$(1) = "-d" then goto 1720
 1110  if argv$(1) = "-p" then th_exec "rm *.ags" : th_exec "rm *.agsc" : th_exec "rm *.agsk" : goto 3330
 1120  if argv$(1) = "-a" and argv$(2) <> "" and argv$(3) <> "" then goto 2870
 1130  if argv$(1) = "-l" then goto 3030
 1140  if argv$(1) = "-c" and argv$(2) <> "" then goto 2990
 1150  if argv$(1) = "-logo" then goto 740
 1160  if argv$(1) = "-o" and argv$(2) <> "" then goto 3180
 1165  if argv$(1) = "-x" then th_exec "send /attach /stop" : goto 3330
 1170  if argv$(1) = "-faq" then goto 320
 1180  if argv$(1) = "-license" then goto 40
 1190  goto 430
 1200  ' *** MESSAGE INPUT AND CONCEALMENT FUNCTIONS ***
 1210  print
 1220  msg$ = "" : print "Message: ";
 1230  hide$ = inkey$ : if hide$ = chr$(13) then goto 1290
 1240  if (hide$ = chr$(127) or hide$ = chr$(8)) and len(msg$) > 0 then msg$ = left$( msg$, abs( len( msg$ )-1 ) ) : print chr$(8) + " " + chr$(8) ;
 1250  if hide$ = chr$(127) or hide$ = chr$(8) then goto 1230
 1260  msg$ = msg$ + hide$ : print "*";
 1270  goto 1230
 1280  print : if len(msg$) < 1 then goto 1220
 1290  file$ = "" : print : print "Filename: ";
 1300  hides$ = inkey$ : if hides$ = chr$(13) then goto 1350
 1310  if (hides$ = chr$(127) or hides$ = chr$(8)) and len(file$) > 0 then file$ = left$( file$, abs( len( file$ )-1 ) ) : print chr$(8) + " " + chr$(8) ;
 1320  if hides$ = chr$(127) or hides$ = chr$(8) then goto 1300
 1330  file$ = file$ + hides$ : print "*";
 1340  goto 1300
 1350  if len(file$) < 1 then goto 1290
 1360  if len(file$) > 3 then ? : ? "Filename must not exceed 3 characters" : goto 1290
 1370  emsg$ = th_b64e$(msg$)
 1380  gosub 1600
 1390  ' *** FILE OUTPUT FUNCTIONS ***
 1400  if argv$(1) <> "-e" then goto 1440
 1410  print : print "Save cipher and key separately? (y/N)";
 1420  keychoice$ = inkey$
 1430  if keychoice$ = "y" then goto 3080
 1440  open file$ + ".ags", as #1 ' FATAL ERROR 02: type 'aegis -faq' for details
 1450  print# 1, encryptedmsg$ + "l" + otp$ + " "
 1460  close #1
 1470  print : th_exec "ls " + file$ + ".ags"
 1480  if argv$(1) = "-es" then now$ = "y" : goto 1520
 1490  print "Send now? [y/N] "; : now$ = inkey$ : print now$ : if now$ = "y" then goto 1510
 1500  goto 1580
 1510  input "To: ", to$ : if to$ = user$ then print "You cannot send a file to yourself! Select another user." : goto 1510
 1520  if to$ = user$ then print "You cannot send a file to yourself! Select another user." : goto 1510
 1530  th_exec "send /attach=" + file$ + ".ags " + to$
 1540  print "[R]esend if the file transfer fails." : print "[D]elete file, cancel send, and close program." :  print "^C to close. Request to send will persist." : if inkey$ <> "d" then goto 1530
 1550  th_exec "send /attach /stop"
 1560  th_exec "rm " + file$ + ".ags"
 1570  print "Message File Deleted"
 1580  goto 3330
 1590  ' *** ENCODE ***
 1600  for e = 1 to len(emsg$) : e$ = mid$(emsg$, e, 1)
 1610  index$ = index$ + array$(asc(e$))
 1620  next e
 1630  ' *** ENCRYPT ***
 1640  for o = 1 to len(index$) : o$ = mid$(index$, o, 1)
 1650  key$ = str$(nint(rnd(9)))
 1660  otp$ = otp$ + key$
 1670  num% = val(o$) - val(key$)
 1680  if num% < 0 then num% = num% + 10
 1690  encryptedmsg$ = encryptedmsg$ + str$(num%)
 1700  next o
 1710  return
 1720  ' *** DECRYPT ***
 1730  ' *** READ DATA FROM FILE AND PUT IT IN CULL$ ***
 1740  print : input "Filename: ", ef$
 1750  if ef$ = "" or ef$ = " " then print "%error - blank filename" : goto 1740
 1760  open ef$ + ".ags", as #1
 1770  if eof(1) = -1 then goto 1800
 1780  input# 1, cull$
 1790  goto 1770
 1800  close #1
 1810  ' *** SPLIT THE DATA INTO MSG AND KEY ***
 1820  if cull$ = "" then ? "FATAL ERROR 01: Type 'aegis -faq' for details" : goto 3330
 1830  readmsg$ = ""
 1840  m$ = mid$(cull$, m, 1) 'FATAL ERROR 01: Type 'aegis -faq' for details
 1850  if m$ = " " then m$ = "" : goto 1880
 1860  if m$ = "l" then m$ = "" : k$ = "" : m = m + 1 : goto 1900
 1870  readmsg$ = readmsg$ + m$
 1880  m = m + 1
 1890  goto 1840
 1900  readkey$ = ""
 1910  k = m
 1920  k$ = mid$(cull$, k, 1)
 1930  if k$ = " " then k$ = "" : k = k + 1 : goto 1970
 1940  readkey$ = readkey$ + k$
 1950  k = k + 1
 1960  goto 1920
 1970  ' *** APPLY MATHS FUNCTIONS TO DECRYPT HASH TO INDEX65 ***
 1980  for V% = 1 to len(readmsg$)
 1990  rm$ = mid$(readmsg$, V%, 1)
 2000  rk$ = mid$(readkey$, V%, 1)
 2010  if V% = len(readkey$) + 1 then goto 2060
 2020  dnum% = val(rm$) + val(rk$)
 2030  if dnum% >= 10 then dnum% = dnum% - 10
 2040  dnum$ = dnum$ + str$(dnum%)
 2050  next V%
 2060  dindex$ = dnum$
 2070  ' *** DECODE ***
 2080  for t = 1 to len(dindex$)
 2090  first$ = mid$(dindex$, t, 1)
 2100  second$ = mid$(dindex$, t + 1, 1)
 2110  both$ = first$ + second$
 2120  ' *** UPPERCASE ***
 2130  if both$ = "00" then t = t + 1 : db64$ = db64$ + ups$("A")
 2140  if both$ = "01" then t = t + 1 : db64$ = db64$ + ups$("B")
 2150  if both$ = "02" then t = t + 1 : db64$ = db64$ + ups$("C")
 2160  if both$ = "03" then t = t + 1 : db64$ = db64$ + ups$("D")
 2170  if both$ = "04" then t = t + 1 : db64$ = db64$ + ups$("E")
 2180  if both$ = "05" then t = t + 1 : db64$ = db64$ + ups$("F")
 2190  if both$ = "06" then t = t + 1 : db64$ = db64$ + ups$("G")
 2200  if both$ = "07" then t = t + 1 : db64$ = db64$ + ups$("H")
 2210  if both$ = "08" then t = t + 1 : db64$ = db64$ + ups$("I")
 2220  if both$ = "09" then t = t + 1 : db64$ = db64$ + ups$("J")
 2230  if both$ = "10" then t = t + 1 : db64$ = db64$ + ups$("K")
 2240  if both$ = "11" then t = t + 1 : db64$ = db64$ + ups$("L")
 2250  if both$ = "12" then t = t + 1 : db64$ = db64$ + ups$("M")
 2260  if both$ = "13" then t = t + 1 : db64$ = db64$ + ups$("N")
 2270  if both$ = "14" then t = t + 1 : db64$ = db64$ + ups$("O")
 2280  if both$ = "15" then t = t + 1 : db64$ = db64$ + ups$("P")
 2290  if both$ = "16" then t = t + 1 : db64$ = db64$ + ups$("Q")
 2300  if both$ = "17" then t = t + 1 : db64$ = db64$ + ups$("R")
 2310  if both$ = "18" then t = t + 1 : db64$ = db64$ + ups$("S")
 2320  if both$ = "19" then t = t + 1 : db64$ = db64$ + ups$("T")
 2330  if both$ = "20" then t = t + 1 : db64$ = db64$ + ups$("U")
 2340  if both$ = "21" then t = t + 1 : db64$ = db64$ + ups$("V")
 2350  if both$ = "22" then t = t + 1 : db64$ = db64$ + ups$("W")
 2360  if both$ = "23" then t = t + 1 : db64$ = db64$ + ups$("X")
 2370  if both$ = "24" then t = t + 1 : db64$ = db64$ + ups$("Y")
 2380  if both$ = "25" then t = t + 1 : db64$ = db64$ + ups$("Z")
 2390  ' *** LOWERCASE ***
 2400  if both$ = "26" then t = t + 1 : db64$ = db64$ + "a"
 2410  if both$ = "27" then t = t + 1 : db64$ = db64$ + "b"
 2420  if both$ = "28" then t = t + 1 : db64$ = db64$ + "c"
 2430  if both$ = "29" then t = t + 1 : db64$ = db64$ + "d"
 2440  if both$ = "30" then t = t + 1 : db64$ = db64$ + "e"
 2450  if both$ = "31" then t = t + 1 : db64$ = db64$ + "f"
 2460  if both$ = "32" then t = t + 1 : db64$ = db64$ + "g"
 2470  if both$ = "33" then t = t + 1 : db64$ = db64$ + "h"
 2480  if both$ = "34" then t = t + 1 : db64$ = db64$ + "i"
 2490  if both$ = "35" then t = t + 1 : db64$ = db64$ + "j"
 2500  if both$ = "36" then t = t + 1 : db64$ = db64$ + "k"
 2510  if both$ = "37" then t = t + 1 : db64$ = db64$ + "l"
 2520  if both$ = "38" then t = t + 1 : db64$ = db64$ + "m"
 2530  if both$ = "39" then t = t + 1 : db64$ = db64$ + "n"
 2540  if both$ = "40" then t = t + 1 : db64$ = db64$ + "o"
 2550  if both$ = "41" then t = t + 1 : db64$ = db64$ + "p"
 2560  if both$ = "42" then t = t + 1 : db64$ = db64$ + "q"
 2570  if both$ = "43" then t = t + 1 : db64$ = db64$ + "r"
 2580  if both$ = "44" then t = t + 1 : db64$ = db64$ + "s"
 2590  if both$ = "45" then t = t + 1 : db64$ = db64$ + "t"
 2600  if both$ = "46" then t = t + 1 : db64$ = db64$ + "u"
 2610  if both$ = "47" then t = t + 1 : db64$ = db64$ + "v"
 2620  if both$ = "48" then t = t + 1 : db64$ = db64$ + "w"
 2630  if both$ = "49" then t = t + 1 : db64$ = db64$ + "x"
 2640  if both$ = "50" then t = t + 1 : db64$ = db64$ + "y"
 2650  if both$ = "51" then t = t + 1 : db64$ = db64$ + "z"
 2660  ' *** NUMBERS ***
 2670  if both$ = "52" then t = t + 1 : db64$ = db64$ + "0"
 2680  if both$ = "53" then t = t + 1 : db64$ = db64$ + "1"
 2690  if both$ = "54" then t = t + 1 : db64$ = db64$ + "2"
 2700  if both$ = "55" then t = t + 1 : db64$ = db64$ + "3"
 2710  if both$ = "56" then t = t + 1 : db64$ = db64$ + "4"
 2720  if both$ = "57" then t = t + 1 : db64$ = db64$ + "5"
 2730  if both$ = "58" then t = t + 1 : db64$ = db64$ + "6"
 2740  if both$ = "59" then t = t + 1 : db64$ = db64$ + "7"
 2750  if both$ = "60" then t = t + 1 : db64$ = db64$ + "8"
 2760  if both$ = "61" then t = t + 1 : db64$ = db64$ + "9"
 2770  ' *** SPECIAL CHARACTERS ***
 2780  if both$ = "62" then t = t + 1 : db64$ = db64$ + "+"
 2790  if both$ = "63" then t = t + 1 : db64$ = db64$ + "/"
 2800  if both$ = "64" then t = t + 1 : db64$ = db64$ + "="
 2810  next t
 2820  ' *** CONVERT Base64 to Plaintext ***
 2830  print : print "Decrypted Message: " + th_b64d$(db64$)
 2840  print
 2850  sleep 0.5 : th_exec "rm " + ef$ + ".ags"
 2860  goto 3330
 2870  ' *** ACCEPT and DECRYPT ***
 2880  th_exec "send /accept=" + argv$(2) + ".ags " + argv$(3)
 2890  ef$ = argv$(2)
 2900  goto 1750
 2910  ' *** SEND PRE-ENCRYPTED FILE ***
 2920  if argv$(3) = user$ then print "You cannot send a file to yourself! Select another user." : goto 3070
 2930  th_exec "send /attach=" + argv$(2) + ".ags" + " " +  argv$(3)
 2940  print "[R]esend if the file transfer fails." : print "[D]elete file and close program." : print "^C to terminate without deleting" : if inkey$ <> "d" then goto 2930
 2950  th_exec "rm " + argv$(2) + ".ags"
 2960  print "Message File Deleted"
 2970  goto 3330
 2980  ' *** PRINT THE CONTENTS OF A .AGS FILE ***
 2990  ? "--- Embedded ---" : ? : th_exec "cat " + argv$(2) + ".ags" : ?
 3000  ? "--- Cipher ---" : ? : th_exec "cat " + argv$(2) + ".agsc" : ?
 3010  ? "---Key---" : ? : th_exec "cat " + argv$(2) + ".agsk" : ?
 3020  goto 3330
 3030  ' *** LIST ALL .AGS FILES ***
 3040  ? "--- Embedded files ---" : ? : th_exec "ls *.ags" : ?
 3050  ? "--- Cipher files ---" : ? : th_exec "ls *.agsc" : ?
 3060  ? "--- Key files --- " : ? : th_exec "ls *.agsk" : ?
 3070  goto 3330
 3080  ' *** SAVE CIPHER AND KEY SEPARATELY ***
 3090  open file$ + ".agsc", as #1
 3100  print# 1, encryptedmsg$
 3110  close #1
 3120  ? : th_exec "ls " + file$ + ".agsc"
 3130  open file$ + ".agsk", as #1
 3140  print# 1, otp$
 3150  close #1
 3160  th_exec "ls " + file$ + ".agsk"
 3170  goto 3330
 3180  ' *** FILE COMBINATION ***
 3190  open argv$(2) + ".agsc", as #1
 3200  if eof(1) = -1 then goto 3230
 3210  input# 1, cipher$
 3220  goto 3200
 3230  close #1
 3240  open argv$(2) + ".agsk", as #1
 3250  if eof(1) = -1 then goto 3280
 3260  input# 1, otpkey$
 3270  goto 3250
 3280  close #1
 3290  open argv$(2) + ".ags", as #1
 3300  print# 1, cipher$ + "l" + otpkey$ + " "
 3310  close #1
 3320  ? "Files combined as: " : th_exec "ls " + argv$(2) + ".ags"
 3330  print "Terminating AEGIS" : END
