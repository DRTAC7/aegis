   10  ver$ = "1.2.6.1"
   20  goto 910
   30  '
   35  'NOTICE: THIS SOFTWARE IS OPEN SOURCE
   36  'IF YOU WISH TO MAKE OFFICIAL MODIFICATIONS TO THIS SOFTWARE
   37  'PLEASE CREATE A PULL REQUEST AT https://www.github.com/DRTAC7/aegis
   40  ?
   50  ? " MIT License                                                                     "
   60  ? "                                                                                 "
   70  ? " Name:           AEGIS - Plaintext Encryption Utility                            "
   80  ? " Copyright:      (c) 2022 telehack.com/u/drtac7                                  "
   90  ? " Author:         drtac7                                                          "
  100  ? " License:        MIT                                                             "
  110  ? "                                                                                 "
  120  ? " Permission is hereby granted, free of charge, to any person obtaining a copy    "
  130  ? " of this software and associated documentation files (the 'Software'), to deal   "
  140  ? " in the Software without restriction, including without limitation the rights    "
  150  ? " to use, copy, modify, merge, publish, distribute, sublicense, and/or sell       "
  160  ? " copies of the Software, and to permit persons to whom the Software is           "
  170  ? " furnished to do so, subject to the following conditions:                        "
  180  ? "                                                                                 "
  190  ? " The above copyright notice and this permission notice shall be included in all  "
  200  ? " copies or substantial portions of the Software.                                 "
  210  ? "                                                                                 "
  220  ? " THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      "
  230  ? " IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        "
  240  ? " FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     "
  250  ? " AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          "
  260  ? " LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   "
  270  ? " OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   "
  280  ? " SOFTWARE.                                                                       "
  290  '
  300  END
  310  '
  320  ?
  330  ? " FAQ:"
  340  ? "     FATAL ERROR 01 will occur if:                                                                    "
  350  ? "         - the encrypted file (.ags, .agsc, .agsk) does not exist                                     "
  360  ? "         - the encrypted file is blank                                                                "
  370  ? "         - an error that causes double filetyping (Ex. msg.ags.ags)                                   "
  380  ? "         - (Most common) you included the filetype (.ags, .agsc, .agsk) when naming or calling a file "
  390  ? "                                                                                                      "
  400  ? "     FATAL ERROR 02 will occur if:                                                                    "
  410  ? "         - you attempt to name the encrypted file '*'                                                 "
  420  ? "         - you are using a mobile device (may not always occur)                                       "
  430  END
  440  ?
  450  ? " AEGIS v" + ver$ + " Encryption Utility for TELEHACK             "
  460  ? "                                                                 "
  470  ? " %usage: aegis <-function> [filename] [sender/receipient]        "
  480  ? "         prefix all functions with -                             "
  490  ? "                                                                 "
  500  ? "         DO NOT INCLUDE THE FILETYPE (.AGS .AGSK .AGSC)          "
  510  ? "         WHEN NAMING OR CALLING A FILE!                          "
  520  ? "                                                                 "
  530  ? " Availble command line functions:                                "
  540  ? "         -e: encrypt a message and save to disk                  "
  550  ? "         -s: send a pre-encrypted file:                          "
  560  ? "         -es: encrypt a message and send immediately             "
  570  ? "         -d: decrypt a message stored on the disk                "
  580  ? "         -a: accept an incoming file and decrypt                 "
  590  ? "         -o: combine cipher and key file                         "
  600  ? "         -c: print the raw contents of a .ags file to the screen "
  610  ? "         -l: list all .ags files present on disk                 "
  620  ? "         -p: purge all .ags files stored on the disk             "
  630  ? "         -x: stop all outgoing sends                             "
  640  ? "         -logo: view AEGIS logo and about screen                 "
  650  ? "         -license: display license information                   "
  660  ? "         -faq: view the frequently asked questions message       "
  670  ? "                                                                 "
  680  ? " Examples:  aegis -es forbin                                     "
  690  ? "            aegis -s msg forbin                                  "
  700  ? "            aegis -a message underwood                           "
  710  ? "            aegis -c file                                        "
  720  ? "            aegis -o file                                        "
  730  ?
  740  END
  750  '
  760  ?
  770  ?"/*"
  780  ?" * $ID: AEGIS v" + ver$ + " x4052 Wed Jun 16 09:34:32 CST 2021 drtac7 $"
  790  ?" */"
  800  ?"     _______________"
  810  ?"     \......|....../"
  820  ?"      \ A E G I S /"
  830  ?"       \....|..../"
  840  ?"        \...|.../"
  850  ?"         \..|../"
  860  ?"          \.|./"
  870  ?"           \|/"
  880  ?
  890  END
  900  '
  910  ' *** Generate ASCII Lookup Table for Encoding *** /// provided by searinox
  920  counter = 0
  930  for i = 65 to 90
  940  tmp$ = str$(counter)
  950  if len(tmp$) = 1 then tmp$ = "0" + tmp$
  960  array$(i) = tmp$ : counter = counter + 1
  970  next i
  980  for i = 97 to 122
  990  tmp$ = str$(counter) : array$(i) = tmp$ : counter = counter + 1
 1000  next i
 1010  for i = 48 to 57
 1020  tmp$ = str$(counter) : array$(i) = tmp$ : counter = counter + 1
 1030  next i
 1040  array$(43) = "62" rem +
 1050  array$(47) = "63" rem /
 1060  array$(61) = "64" rem =
 1070  ' *** COMMANDS ***
 1080  if argv$(1) = "-es" and argv$(2) <> "" then to$ = argv$(2) : goto 1240
 1090  if argv$(1) = "-s" and argv$(2) <> "" and argv$(3) <> "" then to$ = argv$(3) : goto 2940
 1100  if argv$(1) = "-e" then goto 1240
 1110  if argv$(1) = "-d" and argv$(2) <> "" then ef$ = argv$(2) : goto 1780
 1120  if argv$(1) = "-d" then goto 1750
 1130  if argv$(1) = "-p" then th_exec "rm *.ags" : th_exec "rm *.agsc" : th_exec "rm *.agsk" : goto 3360
 1140  if argv$(1) = "-a" and argv$(2) <> "" and argv$(3) <> "" then goto 2900
 1150  if argv$(1) = "-l" then goto 3060
 1160  if argv$(1) = "-c" and argv$(2) <> "" then goto 3020
 1170  if argv$(1) = "-logo" then goto 760
 1180  if argv$(1) = "-o" and argv$(2) <> "" then goto 3210
 1190  if argv$(1) = "-x" then th_exec "send /attach /stop" : goto 3360
 1200  if argv$(1) = "-faq" then goto 330
 1210  if argv$(1) = "-license" then goto 40
 1220  goto 440
 1230  ' *** MESSAGE INPUT AND CONCEALMENT FUNCTIONS ***
 1240  print
 1250  msg$ = "" : print "Message: ";
 1260  hide$ = inkey$ : if hide$ = chr$(13) then goto 1320
 1270  if (hide$ = chr$(127) or hide$ = chr$(8)) and len(msg$) > 0 then msg$ = left$( msg$, abs( len( msg$ )-1 ) ) : print chr$(8) + " " + chr$(8) ;
 1280  if hide$ = chr$(127) or hide$ = chr$(8) then goto 1260
 1290  msg$ = msg$ + hide$ : print "*";
 1300  goto 1260
 1310  print : if len(msg$) < 1 then goto 1250
 1320  file$ = "" : print : print "Filename: ";
 1330  hides$ = inkey$ : if hides$ = chr$(13) then goto 1380
 1340  if (hides$ = chr$(127) or hides$ = chr$(8)) and len(file$) > 0 then file$ = left$( file$, abs( len( file$ )-1 ) ) : print chr$(8) + " " + chr$(8) ;
 1350  if hides$ = chr$(127) or hides$ = chr$(8) then goto 1330
 1360  file$ = file$ + hides$ : print "*";
 1370  goto 1330
 1380  if len(file$) < 1 then goto 1320
 1390  if len(file$) > 3 then ? : ? "Filename must not exceed 3 characters" : goto 1320
 1400  emsg$ = th_b64e$(msg$)
 1410  gosub 1630
 1420  ' *** FILE OUTPUT FUNCTIONS ***
 1430  if argv$(1) <> "-e" then goto 1470
 1440  print : print "Save cipher and key separately? (y/N)";
 1450  keychoice$ = inkey$
 1460  if keychoice$ = "y" then goto 3110
 1470  open file$ + ".ags", as #1 ' FATAL ERROR 02: type 'aegis -faq' for details
 1480  print# 1, encryptedmsg$ + "l" + otp$ + " "
 1490  close #1
 1500  print : th_exec "ls " + file$ + ".ags"
 1510  if argv$(1) = "-es" then now$ = "y" : goto 1550
 1520  print "Send now? [y/N] "; : now$ = inkey$ : print now$ : if now$ = "y" then goto 1540
 1530  goto 1610
 1540  input "To: ", to$ : if to$ = user$ then print "You cannot send a file to yourself! Select another user." : goto 1540
 1550  if to$ = user$ then print "You cannot send a file to yourself! Select another user." : goto 1540
 1560  th_exec "send /attach=" + file$ + ".ags " + to$
 1570  print "[R]esend if the file transfer fails." : print "[D]elete file, cancel send, and close program." :  print "^C to close. Request to send will persist." : if inkey$ <> "d" then goto 1560
 1580  th_exec "send /attach /stop"
 1590  th_exec "rm " + file$ + ".ags"
 1600  print "Message File Deleted"
 1610  goto 3360
 1620  ' *** ENCODE ***
 1630  for e = 1 to len(emsg$) : e$ = mid$(emsg$, e, 1)
 1640  index$ = index$ + array$(asc(e$))
 1650  next e
 1660  ' *** ENCRYPT ***
 1670  for o = 1 to len(index$) : o$ = mid$(index$, o, 1)
 1680  key$ = str$(nint(rnd(9)))
 1690  otp$ = otp$ + key$
 1700  num% = val(o$) - val(key$)
 1710  if num% < 0 then num% = num% + 10
 1720  encryptedmsg$ = encryptedmsg$ + str$(num%)
 1730  next o
 1740  return
 1750  ' *** DECRYPT ***
 1760  ' *** READ DATA FROM FILE AND PUT IT IN CULL$ ***
 1770  print : input "Filename: ", ef$
 1780  if ef$ = "" or ef$ = " " then print "%error - blank filename" : goto 1770
 1790  open ef$ + ".ags", as #1
 1800  if eof(1) = -1 then goto 1830
 1810  input# 1, cull$
 1820  goto 1800
 1830  close #1
 1840  ' *** SPLIT THE DATA INTO MSG AND KEY ***
 1850  if cull$ = "" then ? "FATAL ERROR 01: Type 'aegis -faq' for details" : goto 3360
 1860  readmsg$ = ""
 1870  m$ = mid$(cull$, m, 1) 'FATAL ERROR 01: Type 'aegis -faq' for details
 1880  if m$ = " " then m$ = "" : goto 1910
 1890  if m$ = "l" then m$ = "" : k$ = "" : m = m + 1 : goto 1930
 1900  readmsg$ = readmsg$ + m$
 1910  m = m + 1
 1920  goto 1870
 1930  readkey$ = ""
 1940  k = m
 1950  k$ = mid$(cull$, k, 1)
 1960  if k$ = " " then k$ = "" : k = k + 1 : goto 2000
 1970  readkey$ = readkey$ + k$
 1980  k = k + 1
 1990  goto 1950
 2000  ' *** APPLY MATHS FUNCTIONS TO DECRYPT HASH TO INDEX65 ***
 2010  for V% = 1 to len(readmsg$)
 2020  rm$ = mid$(readmsg$, V%, 1)
 2030  rk$ = mid$(readkey$, V%, 1)
 2040  if V% = len(readkey$) + 1 then goto 2090
 2050  dnum% = val(rm$) + val(rk$)
 2060  if dnum% >= 10 then dnum% = dnum% - 10
 2070  dnum$ = dnum$ + str$(dnum%)
 2080  next V%
 2090  dindex$ = dnum$
 2100  ' *** DECODE ***
 2110  for t = 1 to len(dindex$)
 2120  first$ = mid$(dindex$, t, 1)
 2130  second$ = mid$(dindex$, t + 1, 1)
 2140  both$ = first$ + second$
 2150  ' *** UPPERCASE ***
 2160  if both$ = "00" then t = t + 1 : db64$ = db64$ + ups$("A")
 2170  if both$ = "01" then t = t + 1 : db64$ = db64$ + ups$("B")
 2180  if both$ = "02" then t = t + 1 : db64$ = db64$ + ups$("C")
 2190  if both$ = "03" then t = t + 1 : db64$ = db64$ + ups$("D")
 2200  if both$ = "04" then t = t + 1 : db64$ = db64$ + ups$("E")
 2210  if both$ = "05" then t = t + 1 : db64$ = db64$ + ups$("F")
 2220  if both$ = "06" then t = t + 1 : db64$ = db64$ + ups$("G")
 2230  if both$ = "07" then t = t + 1 : db64$ = db64$ + ups$("H")
 2240  if both$ = "08" then t = t + 1 : db64$ = db64$ + ups$("I")
 2250  if both$ = "09" then t = t + 1 : db64$ = db64$ + ups$("J")
 2260  if both$ = "10" then t = t + 1 : db64$ = db64$ + ups$("K")
 2270  if both$ = "11" then t = t + 1 : db64$ = db64$ + ups$("L")
 2280  if both$ = "12" then t = t + 1 : db64$ = db64$ + ups$("M")
 2290  if both$ = "13" then t = t + 1 : db64$ = db64$ + ups$("N")
 2300  if both$ = "14" then t = t + 1 : db64$ = db64$ + ups$("O")
 2310  if both$ = "15" then t = t + 1 : db64$ = db64$ + ups$("P")
 2320  if both$ = "16" then t = t + 1 : db64$ = db64$ + ups$("Q")
 2330  if both$ = "17" then t = t + 1 : db64$ = db64$ + ups$("R")
 2340  if both$ = "18" then t = t + 1 : db64$ = db64$ + ups$("S")
 2350  if both$ = "19" then t = t + 1 : db64$ = db64$ + ups$("T")
 2360  if both$ = "20" then t = t + 1 : db64$ = db64$ + ups$("U")
 2370  if both$ = "21" then t = t + 1 : db64$ = db64$ + ups$("V")
 2380  if both$ = "22" then t = t + 1 : db64$ = db64$ + ups$("W")
 2390  if both$ = "23" then t = t + 1 : db64$ = db64$ + ups$("X")
 2400  if both$ = "24" then t = t + 1 : db64$ = db64$ + ups$("Y")
 2410  if both$ = "25" then t = t + 1 : db64$ = db64$ + ups$("Z")
 2420  ' *** LOWERCASE ***
 2430  if both$ = "26" then t = t + 1 : db64$ = db64$ + "a"
 2440  if both$ = "27" then t = t + 1 : db64$ = db64$ + "b"
 2450  if both$ = "28" then t = t + 1 : db64$ = db64$ + "c"
 2460  if both$ = "29" then t = t + 1 : db64$ = db64$ + "d"
 2470  if both$ = "30" then t = t + 1 : db64$ = db64$ + "e"
 2480  if both$ = "31" then t = t + 1 : db64$ = db64$ + "f"
 2490  if both$ = "32" then t = t + 1 : db64$ = db64$ + "g"
 2500  if both$ = "33" then t = t + 1 : db64$ = db64$ + "h"
 2510  if both$ = "34" then t = t + 1 : db64$ = db64$ + "i"
 2520  if both$ = "35" then t = t + 1 : db64$ = db64$ + "j"
 2530  if both$ = "36" then t = t + 1 : db64$ = db64$ + "k"
 2540  if both$ = "37" then t = t + 1 : db64$ = db64$ + "l"
 2550  if both$ = "38" then t = t + 1 : db64$ = db64$ + "m"
 2560  if both$ = "39" then t = t + 1 : db64$ = db64$ + "n"
 2570  if both$ = "40" then t = t + 1 : db64$ = db64$ + "o"
 2580  if both$ = "41" then t = t + 1 : db64$ = db64$ + "p"
 2590  if both$ = "42" then t = t + 1 : db64$ = db64$ + "q"
 2600  if both$ = "43" then t = t + 1 : db64$ = db64$ + "r"
 2610  if both$ = "44" then t = t + 1 : db64$ = db64$ + "s"
 2620  if both$ = "45" then t = t + 1 : db64$ = db64$ + "t"
 2630  if both$ = "46" then t = t + 1 : db64$ = db64$ + "u"
 2640  if both$ = "47" then t = t + 1 : db64$ = db64$ + "v"
 2650  if both$ = "48" then t = t + 1 : db64$ = db64$ + "w"
 2660  if both$ = "49" then t = t + 1 : db64$ = db64$ + "x"
 2670  if both$ = "50" then t = t + 1 : db64$ = db64$ + "y"
 2680  if both$ = "51" then t = t + 1 : db64$ = db64$ + "z"
 2690  ' *** NUMBERS ***
 2700  if both$ = "52" then t = t + 1 : db64$ = db64$ + "0"
 2710  if both$ = "53" then t = t + 1 : db64$ = db64$ + "1"
 2720  if both$ = "54" then t = t + 1 : db64$ = db64$ + "2"
 2730  if both$ = "55" then t = t + 1 : db64$ = db64$ + "3"
 2740  if both$ = "56" then t = t + 1 : db64$ = db64$ + "4"
 2750  if both$ = "57" then t = t + 1 : db64$ = db64$ + "5"
 2760  if both$ = "58" then t = t + 1 : db64$ = db64$ + "6"
 2770  if both$ = "59" then t = t + 1 : db64$ = db64$ + "7"
 2780  if both$ = "60" then t = t + 1 : db64$ = db64$ + "8"
 2790  if both$ = "61" then t = t + 1 : db64$ = db64$ + "9"
 2800  ' *** SPECIAL CHARACTERS ***
 2810  if both$ = "62" then t = t + 1 : db64$ = db64$ + "+"
 2820  if both$ = "63" then t = t + 1 : db64$ = db64$ + "/"
 2830  if both$ = "64" then t = t + 1 : db64$ = db64$ + "="
 2840  next t
 2850  ' *** CONVERT Base64 to Plaintext ***
 2860  print : print "Decrypted Message: " + th_b64d$(db64$)
 2870  print
 2880  sleep 0.5 : th_exec "rm " + ef$ + ".ags"
 2890  goto 3360
 2900  ' *** ACCEPT and DECRYPT ***
 2910  th_exec "send /accept=" + argv$(2) + ".ags " + argv$(3)
 2920  ef$ = argv$(2)
 2930  goto 1780
 2940  ' *** SEND PRE-ENCRYPTED FILE ***
 2950  if argv$(3) = user$ then print "You cannot send a file to yourself! Select another user." : goto 3100
 2960  th_exec "send /attach=" + argv$(2) + ".ags" + " " +  argv$(3)
 2970  print "[R]esend if the file transfer fails." : print "[D]elete file and close program." : print "^C to terminate without deleting" : if inkey$ <> "d" then goto 2960
 2980  th_exec "rm " + argv$(2) + ".ags"
 2990  print "Message File Deleted"
 3000  goto 3360
 3010  ' *** PRINT THE CONTENTS OF A .AGS FILE ***
 3020  ? "--- Embedded ---" : ? : th_exec "cat " + argv$(2) + ".ags" : ?
 3030  ? "--- Cipher ---" : ? : th_exec "cat " + argv$(2) + ".agsc" : ?
 3040  ? "---Key---" : ? : th_exec "cat " + argv$(2) + ".agsk" : ?
 3050  goto 3360
 3060  ' *** LIST ALL .AGS FILES ***
 3070  ? "--- Embedded files ---" : ? : th_exec "ls *.ags" : ?
 3080  ? "--- Cipher files ---" : ? : th_exec "ls *.agsc" : ?
 3090  ? "--- Key files --- " : ? : th_exec "ls *.agsk" : ?
 3100  goto 3360
 3110  ' *** SAVE CIPHER AND KEY SEPARATELY ***
 3120  open file$ + ".agsc", as #1
 3130  print# 1, encryptedmsg$
 3140  close #1
 3150  ? : th_exec "ls " + file$ + ".agsc"
 3160  open file$ + ".agsk", as #1
 3170  print# 1, otp$
 3180  close #1
 3190  th_exec "ls " + file$ + ".agsk"
 3200  goto 3360
 3210  ' *** FILE COMBINATION ***
 3220  open argv$(2) + ".agsc", as #1
 3230  if eof(1) = -1 then goto 3260
 3240  input# 1, cipher$
 3250  goto 3230
 3260  close #1
 3270  open argv$(2) + ".agsk", as #1
 3280  if eof(1) = -1 then goto 3310
 3290  input# 1, otpkey$
 3300  goto 3280
 3310  close #1
 3320  open argv$(2) + ".ags", as #1
 3330  print# 1, cipher$ + "l" + otpkey$ + " "
 3340  close #1
 3350  ? "Files combined as: " : th_exec "ls " + argv$(2) + ".ags"
 3360  print "Terminating AEGIS" : END
