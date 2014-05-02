part of Graphics;

abstract class GraphicalObject {
  String objectColor = 'green';
  String boundingColor = '#E3E3E3';
  
  void draw(CanvasRenderingContext2D context, int xpos, int ypos, [bool bordered = false]);
  get width;
  get height;
}