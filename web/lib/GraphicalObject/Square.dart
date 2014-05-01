part of Graphics;

class Square implements GraphicalObject {
  String name = "Square";
  int a;
  
  Square(this.a);
  
  get size => a;
  
  void draw(var context, int xpos, int ypos) {
    context.fillStyle = 'green';
    context.fillRect(xpos, ypos, a, a);
  }
  
  String toString() {
    return "Strana čtverce je: "+a.toString();
  }
}