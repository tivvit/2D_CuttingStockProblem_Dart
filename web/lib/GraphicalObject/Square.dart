part of Graphics;

class Square implements GraphicalObject {
  String name = "Square";
  int a;
  
  Square(this.a);
  
  get width => a;
  get height => width;
  
  void draw(var context, int xpos, int ypos) {
    context.fillStyle = 'green';
    context.fillRect(xpos, ypos, a, a);
  }
  
  String toString() {
    return "Square:"+a.toString();
  }
}