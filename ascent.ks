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
  // telemetry layout
  clearscreen.
  print("+-----------------Telemetry-----------------+").
  print("|        Orbit        |       Program       |").
  print("| Body:               |                     |").
  print("| ApA:                | Pitch:              |").
  print("| PeA:                |                     |").
  print("| ApT:                |                     |").
  print("| PeT:                |                     |").
  print("| Alt:                |                     |").
  print("| Vel:                |                     |").
  print("|                     |                     |").
  print("|                     |                     |").
  print("|                     |                     |").
  print("+-------------------------------------------+").
  // steering
  parameter pitchOver is 3. // initial pitch over (defaults to 3 degrees)
  set mySteer to heading( 90 , 90 - pitchOver).
  until verticalspeed < 0 {
    if verticalspeed >= 100 {
      set mySteer to ship:srfprograde.
    }
    // telemetry output
    set currentBody to body:name.
    set ApA to round(apoapsis / 1000,1) + " km".
    set PeA to round(periapsis / 1000,1) + " km".
    set ApT to round(eta:apoapsis) + " s".
    set PeT to round(eta:periapsis) + " s".
    set currentAlt to round(altitude / 1000,1) + " km".
    set pitch to up:pitch - facing:pitch.
    print(currentBody:padright(14)) at (8,2).
    print(ApA:padright(14)) at (8,3).
    print(PeA:padright(14)) at (8,4).
    print(ApT:padright(14)) at (8,5).
    print(PeT:padright(14)) at (8,6).
    print(currentAlt:padright(14)) at (8,7).
    print(pitch) at (,3)
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

