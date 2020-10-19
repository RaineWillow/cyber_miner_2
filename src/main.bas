#include "fbgfx.bi"


function frameCounter() As integer
    Var t1=Timer,t2=t1
    Static As Double t3,frames,answer
    frames+=1
    If (t2-t3) >= 1 Then t3 = t2 : answer = frames : frames = 0
    Function= answer
end function
'==============================================================================
function regulate(ByVal MyFps As Integer, ByRef fps As Integer) As Integer
    fps=FrameCounter()
    Static As Double timervalue,lastsleeptime
    Dim As Double delta
    Var k=fps-myfps,i=1/myfps
    If Abs(k)>1 Then delta+=i*Sgn(k)
    Var sleeptime=lastsleeptime+(i-Timer+timervalue)*2000+delta
    If sleeptime<1 Then sleeptime=1
    lastsleeptime=sleeptime
    timervalue=Timer
    Return sleeptime
end function
'===============================================================================


screenres 800, 600, 32

sub main()
    dim maxFps as integer = 60
    dim currentFps as integer = 60
    do
        
        screenlock
        cls
        print "FPS: "; currentFps
        screenunlock
        
        sleep regulate(maxFps, currentFps)
        
    loop until inkey = chr(255) + "k" or multikey(FB.SC_ESCAPE)
end sub

main()
