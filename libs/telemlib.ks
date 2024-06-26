// collection of functions for telemetry readout screen

runoncepath("0:ascentscript/libs/drawlib.ks").

set telem_start to false.

function telemStart {
  parameter refresh is 0.5.
  set telem_start to true.

  // set terminal dimenions
  clearscreen.
  drawBorder().

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
}

function telemRefresh {
  print("yuh").
}
