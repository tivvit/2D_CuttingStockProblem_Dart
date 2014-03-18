import 'dart:math';
import 'GraphicalObject.dart';

class Circle implements GraphicalObject {
  String name = "Square";
  int r;
  
  Circle(this.r);
  
  void draw(var context, int xpos, int ypos) {
    print(r);
    context.arc(xpos+r, ypos+r, r, 0, 2*PI);
    context.fillStyle = 'green';
    context.fill();
                        //context.lineWidth = 1;
                        //context.strokeStyle = 'black';
                        //context.stroke();
  }
  
  get size => 2*r;
  
  String toString() {
    return "Poloměr kruhu je: "+r.toString();
  }
}