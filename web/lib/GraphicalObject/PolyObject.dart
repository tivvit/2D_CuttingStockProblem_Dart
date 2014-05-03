part of Graphics;

class PolyObject implements RotatableGraphicalObject {
  String name = "Poly";
  int a, b, c, d, e;
  bool rotated = false;
  
  PolyObject(this.a, this.b, this.c, this.d, this.e){
    int aCandidate = Math.max(a, b);
    b = Math.min(a, b);
    a = aCandidate;
  }
  
  get width => !rotated ? b+c : a;
  get height => !rotated ? a : b+c;
  
  void draw(CanvasRenderingContext2D context, int xpos, int ypos, [bool bordered = false]) {       
    if(bordered) {
      context.fillStyle = boundingColor;
        context.fillRect(xpos, ypos, width, height);
    }
    
    if(bordered)
      context.fillStyle = solutionColor;
    else
      context.fillStyle = objectColor;
    
    int ac = a-1, bc= b-1, cc = c-1, dc = d-1,ec=e-1;

    if(!rotated) {
      context.fillRect(xpos, ypos, bc, ac);
      context.fillRect(xpos+bc, ypos+ec, cc, dc);
    } else {
      context.fillRect(xpos, ypos, ac, bc);
      context.fillRect(xpos+ec, ypos+bc, dc, cc);
    }
      
    if(bordered){
      context.moveTo(xpos, ypos);
      context.beginPath();
      if(!rotated) {
        context.lineTo(xpos+bc, ypos);
        context.lineTo(xpos+bc, ypos+ec);
        context.lineTo(xpos+bc+cc, ypos+ec);
        context.lineTo(xpos+bc+cc, ypos+ec+dc);
        context.lineTo(xpos+bc, ypos+ec+dc);
        context.lineTo(xpos+bc, ypos+ac);
        context.lineTo(xpos, ypos+ac);
        context.lineTo(xpos, ypos);
      }
      else {        
        context.lineTo(xpos+ac, ypos);
        context.lineTo(xpos+ac, ypos+bc);
        context.lineTo(xpos+ec+dc, ypos+bc);
        context.lineTo(xpos+ec+dc, ypos+bc+cc);
        context.lineTo(xpos+ec, ypos+bc+cc);
        context.lineTo(xpos+ec, ypos+bc);
        context.lineTo(xpos, ypos+bc);
        context.lineTo(xpos, ypos);
      }
      context.strokeStyle = border;
      context.stroke();
      context.closePath();
    }
  }
  
  void rotateLeft() {  
    rotated = true;
  }
  
  void rotateBack() {  
      rotated = false;
    }
  
  double area(){
    return (a*b+b*c).toDouble();
  }
  
  double unusedArea(){
    return (b*(a+c))-(a*b+b*c).toDouble();
  }
  
  String toString() {
    return "rectangle("+a.toString()+","+b.toString()+")";
  }
}