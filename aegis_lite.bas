   10  '                                                           _______________
   20  '                                                           \......|....../
   30  ' Name:           AEGIS Lite - Plaintext Encryption Utility  \ A E G I S /
   40  ' Copyright:      (c) 2022 telehack.com/u/drtac7              \....|..../
   50  ' Website:        https://www.github.com/DRTAC7/aegis          \...|.../
   60  ' Author:         drtac7                                        \..|../
   70  ' Contributors:   searinox, zcj                                  \.|./
   80  '                                                                 \|/
   90  ver$ = "1.0.2"
  100  goto 110
  110  ' Generate ASCII Lookup Table for Encoding /// provided by searinox
  120  counter = 0
  130  for i = 65 to 90
  140  tmp$ = str$(counter)
  150  if len(tmp$) = 1 then tmp$ = "0" + tmp$
  160  array$(i) = tmp$ : counter = counter + 1
  170  next
  180  for i = 97 to 122
  190  tmp$ = str$(counter)
  200  array$(i) = tmp$
  210  counter = counter + 1
  220  next
  230  for i = 48 to 57
  240  tmp$ = str$(counter)
  250  array$(i) = tmp$
  260  counter = counter + 1
  270  next
  280  array$(43) = "62" : ' +
  290  array$(47) = "63" : ' /
  300  array$(61) = "64" : ' =
  310  ' MENU
  320  ?
  330  ? "[E]ncrypt"
  340  ? "[D]ecrypt"
  350  ?
  360  select$ = inkey$
  365  if select$ = "e" then goto 1520
  370  if select$ = "d" then goto 570
  380  goto 310
  390  ' ENCODE
  400  for e = 1 to len(emsg$)
  410  e$ = mid$(emsg$, e, 1)
  420  index$ = index$ + array$(asc(e$))
  430  next
  440  ' ENCRYPT
  450  for o = 1 to len(index$)
  460  o$ = mid$(index$, o, 1)
  470  key$ = str$(nint(rnd(9)))
  480  otp$ = otp$ + key$
  490  num% = val(o$) - val(key$)
  500  if num% < 0 then num% = num% + 10
  510  encryptedmsg$ = encryptedmsg$ + str$(num%)
  520  next
  530  ' PRINT ENCRYPTED MESSAGE AND KEY TO SCREEN
  540  ? "Encrypted message: " encryptedmsg$
  550  ? "Decryption key: " + otp$
  560  goto 1640
  570  ' DECRYPT
  580  ' PROMPT USER FOR INPUT
  590  input "Ciphered Message: ", readmsg$
  600  if readmsg$ = "" then goto 590
  610  input "Key:", readkey$
  620  if readkey$ = "" then goto 610
  630  ' APPLY MATHS FUNCTIONS TO DECRYPT HASH TO INDEX65
  640  for V% = 1 to len(readmsg$)
  650  rm$ = mid$(readmsg$, V%, 1)
  660  rk$ = mid$(readkey$, V%, 1)
  670  if V% = len(readkey$) + 1 then goto 720
  680  dnum% = val(rm$) + val(rk$)
  690  if dnum% >= 10 then dnum% = dnum% - 10
  700  dnum$ = dnum$ + str$(dnum%)
  710  next
  720  dindex$ = dnum$
  730  ' DECODE
  740  for t = 1 to len(dindex$)
  750  first$ = mid$(dindex$, t, 1)
  760  second$ = mid$(dindex$, t + 1, 1)
  770  both$ = first$ + second$
  780  ' UPPERCASE
  790  if both$ = "00" then t = t + 1 : db64$ = db64$ + ups$("A")
  800  if both$ = "01" then t = t + 1 : db64$ = db64$ + ups$("B")
  810  if both$ = "02" then t = t + 1 : db64$ = db64$ + ups$("C")
  820  if both$ = "03" then t = t + 1 : db64$ = db64$ + ups$("D")
  830  if both$ = "04" then t = t + 1 : db64$ = db64$ + ups$("E")
  840  if both$ = "05" then t = t + 1 : db64$ = db64$ + ups$("F")
  850  if both$ = "06" then t = t + 1 : db64$ = db64$ + ups$("G")
  860  if both$ = "07" then t = t + 1 : db64$ = db64$ + ups$("H")
  870  if both$ = "08" then t = t + 1 : db64$ = db64$ + ups$("I")
  880  if both$ = "09" then t = t + 1 : db64$ = db64$ + ups$("J")
  890  if both$ = "10" then t = t + 1 : db64$ = db64$ + ups$("K")
  900  if both$ = "11" then t = t + 1 : db64$ = db64$ + ups$("L")
  910  if both$ = "12" then t = t + 1 : db64$ = db64$ + ups$("M")
  920  if both$ = "13" then t = t + 1 : db64$ = db64$ + ups$("N")
  930  if both$ = "14" then t = t + 1 : db64$ = db64$ + ups$("O")
  940  if both$ = "15" then t = t + 1 : db64$ = db64$ + ups$("P")
  950  if both$ = "16" then t = t + 1 : db64$ = db64$ + ups$("Q")
  960  if both$ = "17" then t = t + 1 : db64$ = db64$ + ups$("R")
  970  if both$ = "18" then t = t + 1 : db64$ = db64$ + ups$("S")
  980  if both$ = "19" then t = t + 1 : db64$ = db64$ + ups$("T")
  990  if both$ = "20" then t = t + 1 : db64$ = db64$ + ups$("U")
 1000  if both$ = "21" then t = t + 1 : db64$ = db64$ + ups$("V")
 1010  if both$ = "22" then t = t + 1 : db64$ = db64$ + ups$("W")
 1020  if both$ = "23" then t = t + 1 : db64$ = db64$ + ups$("X")
 1030  if both$ = "24" then t = t + 1 : db64$ = db64$ + ups$("Y")
 1040  if both$ = "25" then t = t + 1 : db64$ = db64$ + ups$("Z")
 1050  ' LOWERCASE
 1060  if both$ = "26" then t = t + 1 : db64$ = db64$ + "a"
 1070  if both$ = "27" then t = t + 1 : db64$ = db64$ + "b"
 1080  if both$ = "28" then t = t + 1 : db64$ = db64$ + "c"
 1090  if both$ = "29" then t = t + 1 : db64$ = db64$ + "d"
 1100  if both$ = "30" then t = t + 1 : db64$ = db64$ + "e"
 1110  if both$ = "31" then t = t + 1 : db64$ = db64$ + "f"
 1120  if both$ = "32" then t = t + 1 : db64$ = db64$ + "g"
 1130  if both$ = "33" then t = t + 1 : db64$ = db64$ + "h"
 1140  if both$ = "34" then t = t + 1 : db64$ = db64$ + "i"
 1150  if both$ = "35" then t = t + 1 : db64$ = db64$ + "j"
 1160  if both$ = "36" then t = t + 1 : db64$ = db64$ + "k"
 1170  if both$ = "37" then t = t + 1 : db64$ = db64$ + "l"
 1180  if both$ = "38" then t = t + 1 : db64$ = db64$ + "m"
 1190  if both$ = "39" then t = t + 1 : db64$ = db64$ + "n"
 1200  if both$ = "40" then t = t + 1 : db64$ = db64$ + "o"
 1210  if both$ = "41" then t = t + 1 : db64$ = db64$ + "p"
 1220  if both$ = "42" then t = t + 1 : db64$ = db64$ + "q"
 1230  if both$ = "43" then t = t + 1 : db64$ = db64$ + "r"
 1240  if both$ = "44" then t = t + 1 : db64$ = db64$ + "s"
 1250  if both$ = "45" then t = t + 1 : db64$ = db64$ + "t"
 1260  if both$ = "46" then t = t + 1 : db64$ = db64$ + "u"
 1270  if both$ = "47" then t = t + 1 : db64$ = db64$ + "v"
 1280  if both$ = "48" then t = t + 1 : db64$ = db64$ + "w"
 1290  if both$ = "49" then t = t + 1 : db64$ = db64$ + "x"
 1300  if both$ = "50" then t = t + 1 : db64$ = db64$ + "y"
 1310  if both$ = "51" then t = t + 1 : db64$ = db64$ + "z"
 1320  ' NUMBERS
 1330  if both$ = "52" then t = t + 1 : db64$ = db64$ + "0"
 1340  if both$ = "53" then t = t + 1 : db64$ = db64$ + "1"
 1350  if both$ = "54" then t = t + 1 : db64$ = db64$ + "2"
 1360  if both$ = "55" then t = t + 1 : db64$ = db64$ + "3"
 1370  if both$ = "56" then t = t + 1 : db64$ = db64$ + "4"
 1380  if both$ = "57" then t = t + 1 : db64$ = db64$ + "5"
 1390  if both$ = "58" then t = t + 1 : db64$ = db64$ + "6"
 1400  if both$ = "59" then t = t + 1 : db64$ = db64$ + "7"
 1410  if both$ = "60" then t = t + 1 : db64$ = db64$ + "8"
 1420  if both$ = "61" then t = t + 1 : db64$ = db64$ + "9"
 1430  ' SPECIAL CHARACTERS
 1440  if both$ = "62" then t = t + 1 : db64$ = db64$ + "+"
 1450  if both$ = "63" then t = t + 1 : db64$ = db64$ + "/"
 1460  if both$ = "64" then t = t + 1 : db64$ = db64$ + "="
 1470  next
 1480  ' CONVERT Base64 to Plaintext
 1490  ? : ? "Decrypted Message: " + th_b64d$(db64$)
 1500  ?
 1510  goto 1640
 1520  ' MESSAGE INPUT AND CONCEALMENT FUNCTIONS
 1530  ?
 1540  msg$ = "" : ? "Message: " ;
 1550  hide$ = inkey$ : if hide$ = chr$(13) then goto 1610
 1560  if (hide$ = chr$(127) or hide$ = chr$(8)) and len(msg$) > 0 then msg$ = left$( msg$, abs( len( msg$ )-1 ) ) : ? chr$(8) + " " + chr$(8) ;
 1570  if hide$ = chr$(127) or hide$ = chr$(8) then goto 1550
 1580  msg$ = msg$ + hide$ : ? "*" ;
 1590  goto 1550
 1600  ? : if len(msg$) < 1 then goto 1540
 1610  emsg$ = th_b64e$(msg$)
 1620  ?
 1630  goto 390
 1640  ? "Terminating AEGIS" : END
 1650  ' Type "run" to execute. Type ^C to exit.
