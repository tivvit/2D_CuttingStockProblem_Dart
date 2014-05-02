part of Graphics;

class Circle implements GraphicalObject {
  String name = "Circle";
  int r;
  
  Circle(this.r);
  
  void draw(CanvasRenderingContext2D context, int xpos, int ypos, [bool bordered = false]) {
    //print(r);
    context.moveTo(xpos+r, ypos+r);
    context.beginPath();
    context.fillStyle = boundingColor;
    context.fillRect(xpos, ypos, 2*r, 2*r);
    context.fillStyle = objectColor;
    context.arc(xpos+r, ypos+r, r, 0, 2*Math.PI);
    context.fill();
    context.closePath();
  }
  
  double area(){
    return (Math.PI*r*r).toDouble();
  }
  
  double unusedArea(){
    return ((4*r*r)-(Math.PI*r*r)).toDouble();
  }
  
  get width => 2*r;
  get height => width;
  
  String toString() {
    return "Circle:"+r.toString();
  }
}