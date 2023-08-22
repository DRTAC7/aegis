   10  ver$ = "1.3"
   20  sleep 0 : PRINT "/*"
   30  sleep 0 : PRINT " * $ID: CITADEL v" + ver$ +" x4051 Wed Jul 15 7:36:23 CST 2020 DRTAC7 $"
   40  sleep 0 : PRINT " */" : sleep 3
   50  sleep 0 : print spc$(3)"........................."
   60  sleep 0 : print spc$(3)"........................."
   70  sleep 0 : print spc$(3)"......C I T A D E L......"
   80  sleep 0 : print spc$(3)"........................."
   90  sleep 0 : print spc$(3)"........................."
  100  sleep 0 : print
  110  sleep 0 : print spc$(3)"Copyright (c) 2020 DRTAC7" : sleep 2
  210  sleep 0 : print
  220  sleep 0 : print spc$(3)"[1]"+chr$(9)+"Generate OTP"
  230  sleep 0 : print spc$(3)"[2]"+chr$(9)+"Encode plaintext"
  240  sleep 0 : print spc$(3)"[3]"+chr$(9)+"Decode plaincode"
  250  sleep 0 : print spc$(3)"[4]"+chr$(9)+"Encrypt plaincode"
  260  sleep 0 : print spc$(3)"[5]"+chr$(9)+"Decrypt cyphercode"
  270  sleep 0 : print spc$(3)"[6]"+chr$(9)+"Show table"
  280  sleep 0 : print spc$(3)"[7]"+chr$(9)+"Quit"
  290  sleep 0 : print
  300  sleep 0 : print "1-7 ? " ; : sleep 0
  310  CD$ = "" : nums$ = "" : formatted = 0
  320  choice$ = inkey$
  330  if val(choice$) > 7 or val(choice$) < 1 then : beep : print : goto 300
  340  print choice$
  350  if choice$ = "1" then goto 430
  360  if choice$ = "2" then goto 600
  370  if choice$ = "3" then goto 1010
  380  if choice$ = "4" then goto 1850
  390  if choice$ = "5" then goto 2080
  400  if choice$ = "6" then print : goto 1590
  410  if choice$ = "7" then print : print "Goodbye!" : print : end
  420  goto 210
  430  print "Number of pads to generate? (1) " ; : thismany = val(input$)
  440  print "Formatted? (y/N) " ; : choice$ = inkey$
  450  print choice$
  460  if choice$ = "y" then formatted = 1
  470  if thismany < 1 then thismany = 1
  480  n = 1
  490  FOR x = 1 to thismany
  500  print " " :  print " "
  510  print "["n"]"
  520  print " "
  530  if formatted = 1 then for k = 1 to 11 : for y = 1 to 5 : for i = 1 to 5 : print str$(nint(rnd(9))) ; : next i : print " " ; : next y : print : print : next k
  540  if formatted <> 1 then for k = 1 to 11 : for y = 1 to 5 : for i = 1 to 5 : print str$(nint(rnd(9))) ; : next i : print " " ; : next y : next k
  550  n = n + 1
  560  sleep 0
  570  print
  580  NEXT x
  590  goto 210
  600  rem bygones be bygones
  610  input "Plaintext? " ; plaintext$
  620  for i = 1 to len(plaintext$) : in$ = mid$(plaintext$,i,1)
  630  REM ENCODE
  640  C$ = in$
  650  if C$="a" then CD$ = CD$ + "1"
  660  if C$="e" then CD$ = CD$ + "2"
  670  if C$="i" then CD$ = CD$ + "3"
  680  if C$="n" then CD$ = CD$ + "4"
  690  if C$="o" then CD$ = CD$ + "5"
  700  if C$="t" then CD$ = CD$ + "6"
  710  if C$="b" then CD$ = CD$ + "70"
  720  if C$="c" then CD$ = CD$ + "71"
  730  if C$="d" then CD$ = CD$ + "72"
  740  if C$="f" then CD$ = CD$ + "73"
  750  if C$="g" then CD$ = CD$ + "74"
  760  if C$="h" then CD$ = CD$ + "75"
  770  if C$="j" then CD$ = CD$ + "76"
  780  if C$="k" then CD$ = CD$ + "77"
  790  if C$="l" then CD$ = CD$ + "78"
  800  if C$="m" then CD$ = CD$ + "79"
  810  if C$="p" then CD$ = CD$ + "80"
  820  if C$="q" then CD$ = CD$ + "81"
  830  if C$="r" then CD$ = CD$ + "82"
  840  if C$="s" then CD$ = CD$ + "83"
  850  if C$="u" then CD$ = CD$ + "84"
  860  if C$="v" then CD$ = CD$ + "85"
  870  if C$="w" then CD$ = CD$ + "86"
  880  if C$="x" then CD$ = CD$ + "87"
  890  if C$="y" then CD$ = CD$ + "88"
  900  if C$="z" then CD$ = CD$ + "89"
  910  if asc(C$) > 47 and asc(C$) < 58 then beep
  920  if C$="." then CD$ = CD$ + "91"
  930  if C$=":" then CD$ = CD$ + "92"
  940  if C$="'" then CD$ = CD$ + "93"
  950  if C$="," then CD$ = CD$ + "94"
  960  if C$="+" then CD$ = CD$ + "95"
  970  if C$="-" then CD$ = CD$ + "96"
  980  if C$="=" then CD$ = CD$ + "97"
  990  if C$=" " then CD$ = CD$ + "99"
 1000  next i : print : print : gosub 1760 : print : CD$ = "" : GOTO 210
 1010  REM DECODE
 1020  print "Plaincode: " ;
 1030  C$ = INKEY$
 1040  IF C$ = " " then goto 1030
 1050  IF C$ = CHR$(13) THEN PRINT : PRINT : PRINT "Plaintext: " + CD$ : PRINT : CD$ = "" : GOTO 210
 1060  REM this was once a strange comment. now it is even stranger
 1070  IF C$="1" THEN PRINT C$ ; : CD$ = CD$ + "a"
 1080  IF C$="2" THEN PRINT C$ ; : CD$ = CD$ + "e"
 1090  IF C$="3" THEN PRINT C$ ; : CD$ = CD$ + "i"
 1100  IF C$="4" THEN PRINT C$ ; : CD$ = CD$ + "n"
 1110  IF C$="5" THEN PRINT C$ ; : CD$ = CD$ + "o"
 1120  IF C$="6" THEN PRINT C$ ; : CD$ = CD$ + "t"
 1130  IF C$="7" THEN C$ = INKEY$ : GOTO 1170
 1140  IF C$="8" THEN C$ = INKEY$ : GOTO 1310
 1150  IF C$="9" THEN C$ = INKEY$ : GOTO 1450
 1160  GOTO 1030
 1170  REM 70 something
 1180  IF C$ = CHR$(13) THEN goto 1050
 1190  if C$ = " " then C$ = INKEY$
 1200  IF C$="0" THEN PRINT "7" + C$ ; : CD$ = CD$ + "b"
 1210  IF C$="1" THEN PRINT "7" + C$ ; : CD$ = CD$ + "c"
 1220  IF C$="2" THEN PRINT "7" + C$ ; : CD$ = CD$ + "d"
 1230  IF C$="3" THEN PRINT "7" + C$ ; : CD$ = CD$ + "f"
 1240  IF C$="4" THEN PRINT "7" + C$ ; : CD$ = CD$ + "g"
 1250  IF C$="5" THEN PRINT "7" + C$ ; : CD$ = CD$ + "h"
 1260  IF C$="6" THEN PRINT "7" + C$ ; : CD$ = CD$ + "j"
 1270  IF C$="7" THEN PRINT "7" + C$ ; : CD$ = CD$ + "k"
 1280  IF C$="8" THEN PRINT "7" + C$ ; : CD$ = CD$ + "l"
 1290  IF C$="9" THEN PRINT "7" + C$ ; : CD$ = CD$ + "m"
 1300  GOTO 1030
 1310  REM 80 something
 1320  IF C$ = CHR$(13) THEN goto 1050
 1330  if C$ = " " then : C$ = INKEY$
 1340  IF C$="0" THEN PRINT "8" + C$ ; : CD$ = CD$ + "p"
 1350  IF C$="1" THEN PRINT "8" + C$ ; : CD$ = CD$ + "q"
 1360  IF C$="2" THEN PRINT "8" + C$ ; : CD$ = CD$ + "r"
 1370  IF C$="3" THEN PRINT "8" + C$ ; : CD$ = CD$ + "s"
 1380  IF C$="4" THEN PRINT "8" + C$ ; : CD$ = CD$ + "u"
 1390  IF C$="5" THEN PRINT "8" + C$ ; : CD$ = CD$ + "v"
 1400  IF C$="6" THEN PRINT "8" + C$ ; : CD$ = CD$ + "w"
 1410  IF C$="7" THEN PRINT "8" + C$ ; : CD$ = CD$ + "x"
 1420  IF C$="8" THEN PRINT "8" + C$ ; : CD$ = CD$ + "y"
 1430  IF C$="9" THEN PRINT "8" + C$ ; : CD$ = CD$ + "z"
 1440  GOTO 1030
 1450  REM 90 something
 1460  IF C$ = CHR$(13) THEN goto 1050
 1470  rem IF C$="0" THEN C$ = INKEY$ : PRINT "90" + C$ ; : CD$ = CD$ + C$ : goto 1030
 1480  if C$ = " " then C$ = INKEY$
 1490  IF C$="1" THEN PRINT "9" + C$ ; : CD$ = CD$ + "."
 1500  IF C$="2" THEN PRINT "9" + C$ ; : CD$ = CD$ + CHR$(58)
 1510  IF C$="3" THEN PRINT "9" + C$ ; : CD$ = CD$ + "'"
 1520  IF C$="4" THEN PRINT "9" + C$ ; : CD$ = CD$ + ","
 1530  IF C$="5" THEN PRINT "9" + C$ ; : CD$ = CD$ + "+"
 1540  IF C$="6" THEN PRINT "9" + C$ ; : CD$ = CD$ + "-"
 1550  IF C$="7" THEN PRINT "9" + C$ ; : CD$ = CD$ + "="
 1560  IF C$="9" THEN PRINT "9" + C$ ; : CD$ = CD$ + " "
 1570  GOTO 1030
 1580  REM TABLE
 1590  PRINT "EXAMPLE TABLE: (Note: Numbers must be encoded as words; numerical symbols are not supported.)"
 1600  print
 1610  print "+----------------------------------------+"
 1620  print "|CODE | A  | E | I | N | O | T | CT No 1 |"
 1630  print "|  0  | 1  | 2 | 3 | 4 | 5 | 6 | ENGLISH |"
 1640  print "|--------------------------------------------------+"
 1650  print "|  B  | C  | D  | F  | G  | H  | J  | K  | L  | M  |"
 1660  print "|  70 | 71 | 72 | 73 | 74 | 75 | 76 | 77 | 78 | 79 |"
 1670  print "|-----|----|----|----|----|----|----|----|----|----|"
 1680  print "|  P  | Q  | R  | S  | U  | V  | W  | X  | Y  | Z  |"
 1690  print "|  80 | 81 | 82 | 83 | 84 | 85 | 86 | 87 | 88 | 89 |"
 1700  print "|-----------------------------------------------------------+"
 1710  print "| FIG | (.) | (:) | (') | (,) | (+) | (-) | (=) | REQ | SPC |"
 1720  print "| N/A |  91 |  92 |  93 |  94 |  95 |  96 |  97 | N/A | N/A |"
 1730  print "+-----------------------------------------------------------+"
 1740  print " "
 1750  goto 210
 1760  rem Format output
 1770  print "Plaincode: " ;
 1780  for o = 1 to len(CD$)
 1790  print mid$(CD$,o,1) ;
 1800  if o mod 5 = 0 then print " " ;
 1810  next o
 1820  if 5-(len(CD$) mod 5) <> 5 then print string$(5-(len(CD$) mod 5),"9")
 1830  print
 1840  return
 1850  input "Plaincode: ", pc$
 1860  input "OTP Key: ", ec$
 1870  FOR I% = 1 TO LEN(pc$)
 1880  C$ = MID$(pc$, I%, 1)
 1890  D$ = MID$(ec$, I%, 1)
 1900  if C$ = " " and D$ <> " " then print "%formats do not match" : goto 210
 1910  if C$ = " " then goto 1960
 1920  if D$ = "" then print "%key too short" : goto 210
 1930  num% = VAL(C$)-VAL(D$)
 1940  if num% < 0 then num% = num% + 10
 1950  nums$ = nums$ + str$(num%)
 1960  NEXT I%
 1970  CD$ = nums$ : gosub 1990
 1980  goto 210
 1990  rem Formats output
 2000  print "Output: " ;
 2010  for o = 1 to len(CD$)
 2020  print mid$(CD$,o,1) ;
 2030  if o mod 5 = 0 then print " " ;
 2040  next o
 2050  if 5-(len(CD$) mod 5) <> 5 then print string$(5-(len(CD$) mod 5),"9")
 2060  print
 2070  return
 2080  input "Encrypted Code: ", pc$
 2090  if pc$ = "" then goto 2080
 2100  input "OTP Key: ", ec$
 2110  if ec$ = "" then goto 2100
 2120  FOR I% = 1 TO LEN(pc$)
 2130  C$ = MID$(pc$, I%, 1)
 2140  D$ = MID$(ec$, I%, 1)
 2150  if C$ = " " and D$ <> " " then print "%formats do not match" : goto 210
 2160  if C$ = " " then goto 2210
 2170  if C$ = "" then print "%key too short" : goto 210
 2180  num% = VAL(C$)+VAL(D$)
 2190  if num% >= 10 then num% = num% - 10
 2200  nums$ = nums$ + str$(num%)
 2210  NEXT I%
 2220  CD$ = nums$ : gosub 1990
 2230  goto 210
