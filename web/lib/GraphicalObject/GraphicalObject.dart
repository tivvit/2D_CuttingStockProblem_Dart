part of Graphics;

abstract class GraphicalObject {
  void draw(CanvasRenderingContext2D context, int xpos, int ypos, [bool bordered = false]);
  double area();
  double unusedArea();
  get width;
  get height;
}