// ascent script

// variables
set mySteer to up. 
lock steering to mySteer.
lock throttle to 1.

// countdown function
function countdown {
  parameter secs is 10. // countdown time in seconds (defaults to 10)
  print "Launch in:".
  from {secs.} until secs = 0 step {set secs to secs - 1.} do {
    print( secs + "...").
    wait 1.
  }
}

// gravity turn function
function gravityturn {
  parameter pitchOver is 3. // initial pitch over (defaults to 3 degrees)
  set mySteer to heading( 90 , 90 - pitchOver).
  until verticalspeed < 0 {
    wait until verticalspeed >= 100.
    set mySteer to ship:srfprograde.
  }
}

// defining first stage engine
set firstEngine to 1. 
list engines in myEngines.
for eng in myEngines {
  print("current stage " + stage:number).
  print("engine stage: " + eng:stage).
  if eng:stage = stage:number - 1  {
    set firstEngine to eng.
    print(eng).
    break.
  }
}

// script
countdown(5).
stage.
wait until stage:ready.
until firstEngine:thrust >= firstEngine:maxthrust {
  print("thrust: " + firstEngine:thrust + "  maxthrust: " + firstEngine:maxthrust).
}
stage.
gravityturn().
