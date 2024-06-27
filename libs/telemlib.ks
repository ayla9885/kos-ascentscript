// collection of functions for telemetry readout screen

runoncepath("0:ascentscript/libs/drawlib.ks").

set telem_start to false.

function telemStart {
  parameter refresh_int is 0.5.
  set telem_start to true.

  set terminal:height to 17.
  set terminal:width to 35.
  clearscreen.
  drawBorder().
  //drawVertLine().
  drawTitle("Telemetry").
  //print("Orbit").
  //print("Program").
  drawText("Bdy:|Sts:|ApA:|PeA:|ApT:|PeT:|Alt:|Vel:", 2, 2).

  set refresh_time to time.
  when time - refresh_time > refresh_int then {
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
  set currentBody to body:name.
  set ApA to round(apoapsis / 1000,1) + " km".
  set PeA to round(periapsis / 1000,1) + " km".
  set ApT to round(eta:apoapsis) + " s".
  set PeT to round(eta:periapsis) + " s".
  set currentAlt to round(altitude / 1000,1) + " km".
  if ship:status <> "ORBITING" and ship:status <> "ESCAPING" and ship:status <> "SUB_ORBITAL" {
    set currentVel to round(airspeed) + " m/s".
  } else {
    set currentVel to round(velocity:orbit:mag) + " m/s".
  }
  set pitch to up:pitch - facing:pitch.
  drawText(currentBody:padright(14) + "|" + ship:status:replace("_", " ") + "|" + ApA:padright(14) + "|" + PeA:padright(14) + "|" + ApT:padright(14) + "|" + PeT:padright(14) + "|" + currentAlt:padright(14) + "|" + currentVel:padright(14) , 7, 2).
}
