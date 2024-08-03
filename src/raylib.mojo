from sys import ffi

fn Color(r: UInt8, g: UInt8, b: UInt8, a: UInt8)->UInt32:
  var _r = r.cast[UInt32.type]()
  var _g = g.cast[UInt32.type]() << 8
  var _b = b.cast[UInt32.type]() << 16
  var _a = a.cast[UInt32.type]() << 24

  return _r + _g + _b + _a


fn main():
  print("Hello")
  var handle = ffi.DLHandle("raylib-5.0/lib/libraylib.so")

  var init_window = handle.get_function[fn(UInt64, UInt64, StringLiteral )->None]('InitWindow')
  var close_window = handle.get_function[fn()->None]('CloseWindow')
  var window_should_close = handle.get_function[fn()->UInt8]('WindowShouldClose')

  var begin_drawing = handle.get_function[fn()->None]('BeginDrawing')
  var end_drawing = handle.get_function[fn()->None]('EndDrawing')
  var red : UInt32 = 254
  var green = red << 8
  var blue = green << 8
  var yellow = green + red
  var cyan = green + blue
  var magenta = blue + red
  var white = red + green + blue
  var black = 0

  var clear_background = handle.get_function[fn(UInt32)->None]('ClearBackground')
  init_window(800, 450, 'Window Name')
  while not window_should_close():
    begin_drawing()
    clear_background(black)
    end_drawing()
  close_window()

