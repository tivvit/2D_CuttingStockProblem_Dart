part of Graphics;

class Rectangle implements GraphicalObject {
  String name = "Rectangle";
  int a, b;
  
  Rectangle(this.a, this.b);
  
  get width => Math.max(a,b);
  get height => Math.min(a, b);
  
  void draw(var context, int xpos, int ypos) {
    context.fillStyle = 'green';
    int max = Math.max(a,b), min = Math.min(a,b);
    context.fillRect(xpos, ypos, max, min);
  }
  
  String toString() {
    return "rectangle(: "+a.toString()+","+b.toString()+")";
  }
}