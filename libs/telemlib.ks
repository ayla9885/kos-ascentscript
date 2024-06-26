// collection of functions for telemetry readout screen

runoncepath("0:ascentscript/libs/drawlib.ks").

set telem_start to false.

function telemStart {
  parameter refresh is 0.5.
  set telem_start to true.

  set terminal:height to 13 
  set terminal:width to 23
  clearscreen.
  drawBorder().
  drawVertLine().
  drawTitle("Telemetry").
  print("Orbit").
  print("Program").
  print("Body:").
  print("ApA:").
  print("Pitch:").
  print("PeA:").
  print("ApT:").
  print("PeT:").
  print("Alt:").
  print("Vel:").

  set refresh_time to time.
  when time - refresh_time > refresh then {
    if telem_start {
      telemRefresh().
      set refresh_time to time.
      preserve.
    } 
  }

}

function telemEnd {
  set telem_start to false.
  clearscreen.
}

function telemRefresh {
  print("yuh").
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
