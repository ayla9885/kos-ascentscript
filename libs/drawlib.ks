// collection of functions for drawing shapes, lines, etc. to terminal

function drawBorder {
  set border_list to list(). 
  from {local x is terminal:width - 2.} until x = 0 step {set x to x - 1.} do {
    border_list:add("-").
  }

  print("+" + border_list:join("") + "+"). // top border
  from {local x is terminal:height - 3.} until x = 0 step {set x to x - 1.} do { // side borders
    print ("|" + "":padright(terminal:width - 2) + "|").
  }
  print("+" + border_list:join("") + "+"). // bottom border
}

function drawTitle {
  parameter draw_title.
  print(draw_title) at ((terminal:width / 2) - (draw_title:length / 2), 0).
}
