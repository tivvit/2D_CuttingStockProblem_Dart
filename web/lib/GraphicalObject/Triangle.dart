part of Graphics;

class Triangle implements GraphicalObject {
  String name = "Triangle";
  int a,b,c;
  
  Triangle(this.a, this.b, this.c) {
    List sides = _getSortedSides();
    a = sides[0];
    b = sides[1];
    c = sides[2];
  }
  
  void draw(var context, int xpos, int ypos) {
    double v = (c*b)/Math.sqrt(Math.pow(c,2)+Math.pow(b,2));
    
    context.moveTo(xpos, ypos);
    context.fillStyle = '#E3E3E3';
    context.fillRect(xpos, ypos, a, v);
    context.fillStyle = 'green';
    context.beginPath();
    context.lineTo(xpos+a,ypos);
    context.lineTo(xpos+(Math.pow(c,2)/Math.sqrt(Math.pow(c,2)+Math.pow(b,2))),ypos+v);
    context.lineTo(xpos,ypos);
    context.fill();
    context.closePath();
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
  
  get size => a;
  
  String toString() {
    return "Triangle: "+a.toString()+" "+b.toString()+" "+c.toString();
  }
}