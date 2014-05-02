part of Graphics;

class Rectangle implements GraphicalObject {
  String name = "Rectangle";
  int a, b;
  
  Rectangle(this.a, this.b);
  
  get width => Math.max(a,b);
  get height => Math.min(a, b);
  
  void draw(var context, int xpos, int ypos, [bool bordered = false]) {
    context.fillStyle = objectColor;
    int max = width, min = height;
    if(bordered){
      max--;
      min--;
    }
      
    context.fillRect(xpos, ypos, max, min);
    if(bordered){
      context.beginPath();
      context.rect(xpos, ypos, max, min);
      context.stroke();
      context.closePath();
    }
  }
  
  String toString() {
    return "rectangle(: "+a.toString()+","+b.toString()+")";
  }
}