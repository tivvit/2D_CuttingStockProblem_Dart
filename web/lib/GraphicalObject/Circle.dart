part of Graphics;

class Circle implements GraphicalObject {
  String name = "Circle";
  int r;
  
  Circle(this.r);
  
  void draw(var context, int xpos, int ypos) {
    //print(r);
    context.moveTo(xpos+r, ypos+r);
    context.fillStyle = '#E3E3E3';
    context.fillRect(xpos, ypos, 2*r, 2*r);
    context.fillStyle = 'green';
    context.arc(xpos+r, ypos+r, r, 0, 2*Math.PI);
    context.fill();
    context.closePath();
  }
  
  get width => 2*r;
  get height => width;
  
  String toString() {
    return "Circle:"+r.toString();
  }
}