$regfile = "m16def.dat"
$crystal = 8000000
Config Timer0 = Timer , Prescale = 64
Enable Timer0
Start Timer0

Dim Timer0_ovf As Long , X1 As Single , X2 As Single , Vel_cm_s As Single , Meas_time As Single

Enable Interrupts
On Ovf0 Tim0_ovf

Dim Ultarpulse As Word
Dim Dis_cm As Word
Config Lcdpin = Pin , Db4 = Portd.3 , Db5 = Portd.4 , Db6 = Portd.5 , Db7 = Portd.6 , E = Portd.2 , Rs = Portd.0 , Wr = Portd.1
Config Portd.7 = Output
Set Portd.7
Config Lcd = 16 * 2
Config Pina.2 = Output
   Do
   Porta.2 = 0
   Pulseout Porta , 3 , 40
   Pulsein ultarpulse , Pina , 3 , 1
   Ultarpulse = Ultarpulse * 10
   Dis_cm = Ultarpulse / 58
   Meas_time = Timer0_ovf + Timer0
   Timer0_ovf = 0 : Timer0 = 0
   Meas_time = 0.000008 * Meas_time
   X1 = X2
   X2 = Dis_cm
   Vel_cm_s = X2 - X1
   Vel_cm_s = Vel_cm_s / Meas_time
   Home
   Lcd "Dis:" ; Dis_cm ; "          "
   Locate 2 , 1
   Lcd "VEL:" ; Vel_cm_s ; "          "
   Waitms 300
   Loop
   End


Tim0_ovf:
Timer0_ovf = Timer0_ovf + 256

Return

