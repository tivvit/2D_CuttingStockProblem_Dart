library Cut;

import 'dart:html';

class Cut implements Comparable{
  double x;
  double y;
  double width;
  double height;
  
  Cut(this.x, this.y, this.width, this.height);
  
  double area(){
    return width*height;
  }
  
  void draw(CanvasRenderingContext2D context) {
    //print(x.toString()+" "+y.toString()+" "+width.toString()+" "+height.toString());
    context.fillStyle = 'blue';
    context.fillRect(x, y, width, height);
  }
  
  bool isSuitable(double Oarea, double Owidth, double Oheight) {
    if(Oarea > area() || Owidth > width || Oheight > height)
      return false;
    else
      return true;
  }
  
  Comparable compareTo(Cut b){
    if(area() < b.area())
      return 1;
    if(area() == b.area())
      return 0;
    else
      return -1;
  }
}