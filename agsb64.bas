
if argv$(1) = "e" then goto 100
if argv$(1) = "d" then goto 200

100 ' LAYER WITH BASE 64
        ? : ? "Layering " + argv$(2)
    105 open argv$(2) , as #1
    106 if typ(1) = 3 then goto 107
        input# 1, eLayer$
        goto 106
    107 close #1

    eLayered$ = th_sed$(th_b64e$(eLayer$),"\n","","g")

110 ' DELETE AND REPLACE E
        open argv$(2), as #1
        ?# 1, eLayered$
        close #1
        END

200 ' DELAYER BASE64
        ? "Delayering " + argv$(2)
    205 open argv$(2) , as #1
    206 if EOF(1) then goto 207
        input# 1, dLayer$
        goto 206
    207 close #1

    dLayered$ = th_sed$(th_b64d$(dLayer$),"\n","","g")

210 ' DELETE AND REPLACE D
        open argv$(2), as #1
        ?# 1, dLayered$
        close #1
        END
