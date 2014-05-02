part of Graphics;

class Rectangle implements RotatableGraphicalObject {
  String name = "Rectangle";
  int a, b;
  bool rotated = false;
  
  Rectangle(this.a, this.b){
    int aCandidate = Math.max(a, b);
    b = Math.min(a, b);
    a = aCandidate;
  }
  
  get width => !rotated ? a : b;
  get height => !rotated ? b : a;
  
  void draw(CanvasRenderingContext2D context, int xpos, int ypos, [bool bordered = false]) {
    context.fillStyle = objectColor;
    int ba = a, bb = b;
    if(bordered){
      ba--;
      bb--;
    }
    
    if(rotated) {
      int tmp = ba;
      ba = bb;
      bb = tmp;
    }
      
    context.fillRect(xpos, ypos, ba, bb);
    if(bordered){
      context.beginPath();
      context.rect(xpos, ypos, ba, bb);
      context.stroke();
      context.closePath();
    }
  }
  
  void rotateLeft() {  
    rotated = true;
  }
  
  double area(){
    return (a*b).toDouble();
  }
  
  double unusedArea(){
    return .0;
  }
  
  String toString() {
    return "rectangle("+a.toString()+","+b.toString()+")";
  }
}