part of Graphics;

class Triangle implements RotatableGraphicalObject {
  String name = "Triangle";
  int a,b,c;
  double v;
  bool rotated = false;
  
  Triangle(this.a, this.b, this.c) {
    List sides = _getSortedSides();
    a = sides[0];
    b = sides[1];
    c = sides[2];
    v = (c*b)/Math.sqrt(Math.pow(c,2)+Math.pow(b,2));
  }
  
  void draw(CanvasRenderingContext2D context, int xpos, int ypos, [bool bordered = false]) {
    context.moveTo(xpos, ypos);
    context.fillStyle = boundingColor;
    if(!rotated)
      context.fillRect(xpos, ypos, a, v);
    else
      context.fillRect(xpos, ypos, v, a);
    context.fillStyle = objectColor;
    context.beginPath();
    if(!rotated) {
      context.lineTo(xpos+a,ypos);
      context.lineTo(xpos+(Math.pow(c,2)/Math.sqrt(Math.pow(c,2)+Math.pow(b,2))),ypos+v);
      context.lineTo(xpos,ypos);
    }
    else {
      context.lineTo(xpos,ypos+a);
      context.lineTo(xpos+v,ypos+(Math.pow(c,2)/Math.sqrt(Math.pow(c,2)+Math.pow(b,2))));
      context.lineTo(xpos,ypos);
    }
    context.fill();
    context.closePath();
  }
  
  double area(){
    return (.5*a*v).toDouble();
  }
  
  double unusedArea(){
    return (.5*a*v).toDouble();
  }
  
  void rotateLeft() {  
    rotated = true;
  }
  
  List _getSortedSides() {
    List elements = [a, b, c];
    elements.sort((x, y) => _descendant(x, y));
    
    return elements;
  }
  
  int _descendant(int a, int b) {
    if (a < b)
      return 1;
    if (a == b)
      return 0;
    else
      return -1;
  }
  
  get width => !rotated ? a : v.toInt();
  get height => !rotated ? v.toInt() : a;
  
  String toString() {
    return "Triangle: "+a.toString()+" "+b.toString()+" "+c.toString();
  }
}