import 'GraphicalObject.dart';

class Square implements GraphicalObject {
  String name = "Square";
  int a;
  
  Square(this.a);
  
  void draw (var context, int pos) {
    context.rect(pos, 5, a, a);
                        context.fillStyle = 'green';
                        context.fill();
                        //context.lineWidth = 1;
                        //context.strokeStyle = 'black';
                        //context.stroke();
  }
  
  String toString() {
    return "Strana čtverce je: "+a.toString();
  }
}