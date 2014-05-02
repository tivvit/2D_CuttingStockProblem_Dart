part of Graphics;

class Square implements GraphicalObject {
  String name = "Square";
  int a;
  
  Square(this.a);
  
  get width => a;
  get height => width;
  
  void draw(var context, int xpos, int ypos, [bool bordered = false]) {
    context.fillStyle = objectColor;
    int ba;
    if(bordered)
      ba = a - 1;
    else
      ba = a;
    context.fillRect(xpos, ypos, ba, ba);
    if(bordered){
      context.beginPath();
      context.rect(xpos, ypos, ba, ba);
      context.stroke();
      context.closePath();
    }
  }
  
  String toString() {
    return "Square:"+a.toString();
  }
}