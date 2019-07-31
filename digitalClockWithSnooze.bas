$regfile = "m16def.dat"
$crystal = 8000000
Config Lcdpin = Pin , Db4 = Portd.3 , Db5 = Portd.4 , Db6 = Portd.5 , Db7 = Portd.6 , E = Portd.2 , Rs = Portd.0 , Wr = Portd.1
 Config Portd.7 = Output
 Config Porta = Output
 Set Portd.7
Config Lcd = 16 * 2
Declare Sub Incr_h
Declare Sub Incr_m
Declare Sub Setalarm
Declare Sub Incr_a_h
Declare Sub Incr_a_m
Declare Sub Snooze
Dim S As Byte , M As Byte , H As Byte
Dim A_h As Byte , A_m As Byte
Dim S_m As Byte
Dim S_h As Byte

Main:
S = 0 : M = 0 : H = 1
Cls : Home : Lcd "time"
Do

   If Pinc.0 = 1 Then Call Incr_h
   If Pinc.1 = 1 Then Call Incr_m
   Locate 2 , 1
   Lcd "" ; H ; ":" ; M ; ":" ; S ; "     "
   Incr S
   If Pinc.2 = 1 Then Call Setalarm
   If A_h = H And A_m = M Then
      Set Porta.0
      Reset Porta.1
      Set Porta.2
      Reset Porta.3
      Set Porta.4
      Reset Porta.5
      Set Porta.6
      Reset Porta.7
      Waitms 495
      Toggle Porta
      Waitms 500
      If Pinc.6 = 1 Then Call Snooze
      Else
      Reset Porta.0
      Reset Porta.1
      Reset Porta.2
      Reset Porta.3
      Reset Porta.4
      Reset Porta.5
      Reset Porta.6
      Reset Porta.7
      Waitms 995
      End If

    If S > 59 Then
         S = 0
         Incr M
         Shiftcursor Left , 2
         Lcd ""
         If M > 59 Then
            Incr H
            M = 0
            If H > 12 Then
               Jmp Main


         End If
      End If
   End If
Loop

End

Incr_m:
    Incr M
    If M > 59 Then
       Cls : Home : Lcd "time:"
       M = 0
    End If
 Return

 Incr_h:
    Incr H
    If H > 12 Then
       H = 1 : Cls : Home : Lcd "time:"
    End If
 Return

 Incr_a_h:
     Incr A_h
     If A_h > 12 Then
     A_h = 1 : Cls : Home : Lcd "setalarm:"
     End If
 Return
 Incr_a_m:
     Incr A_m
     If A_m > 59 Then
      Cls : Home : Lcd "setalarm:"
      A_m = 0
     End If
 Return

 Setalarm:

   Do
      Home : Lcd "setalarm:" ; "        "
      If Pinc.3 = 1 Then
         While Pinc.3 = 1
         Wend
         Call Incr_a_h
      End If
      If Pinc.4 = 1 Then
         While Pinc.4 = 1
         Wend
         Call Incr_a_m
      End If
      Locate 2 , 1
      Lcd "" ; A_h ; ":" ; A_m ; "          "
      If Pinc.5 = 1 Then
         Cls : Home : Lcd "time:" ; "       "
         Exit Do

      End If
   Loop

 Return

Snooze:


 Reset Porta.0
 Reset Porta.1
 Reset Porta.2
 Reset Porta.3
 Reset Porta.4
 Reset Porta.5
 Reset Porta.6
 Reset Porta.7

 A_m = A_m + 2

    If A_m > 59 Then
    A_m = 0
    Incr A_h
       If A_h > 12 Then
       A_h = 1
       End If
    End If

 Return








