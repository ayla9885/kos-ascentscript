// ascent script
clearscreen.

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
  print("Go!").
}

// gravity turn function
function gravityturn {
  clearscreen.
  parameter pitchOver is 3. // initial pitch over (defaults to 3 degrees)
  set mySteer to heading( 90 , 90 - pitchOver).
  until verticalspeed < 0 {
    if verticalspeed >= 100 {
      set mySteer to ship:srfprograde.
    }
    // telemetry output
    print("Pitch: " + round(pitchOver) + "     ") at (0,0).
    print("Surface Velocity: " + round(airspeed) + "     ") at (0,1).
    print("Altitude: " + round(altitude) + "     ") at (0,2).
  }
}

// defining first stage engine
set firstEngine to 1. 
list engines in myEngines.
for eng in myEngines {
  if eng:stage = stage:number - 1  {
    set firstEngine to eng.
    break.
  }
}

// script
countdown(5).
stage.
wait until stage:ready.
wait until firstEngine:thrust >= firstEngine:maxthrust.
stage.
gravityturn().

