library CuttingStock;

import 'dart:collection';
import 'dart:html';
import 'dart:math' as Math;
import '../CanvasHelper.dart';

import '../Graphics.dart' as GR;

class CuttingStock {  
  Queue<GR.GraphicalObject> queue = new Queue();
  
  void addObjects(List objects) {
    objects.sort((a, b) => _bigger(a,b));
    for(int i = 0; i < objects.length-1;i++){
      queue.add(objects.elementAt(i));
    }
  }
  
  int _bigger(GR.GraphicalObject a, GR.GraphicalObject b) {
    if (a.width < b.width)
      return 1;
    if (a.width == b.width)
      return 0;
    else
      return -1;
  }
  
  void draw(CanvasHelper ch) {
    int width = 0, height = 0, max = 0; 
    
    while(!queue.isEmpty) {
      GR.GraphicalObject processed = queue.removeFirst();
      if(width+processed.width >= ch.canvas.width) {
            height += max;
            width = 0;
            max = 0;
          }
          
      max = Math.max(max, processed.height); 
      processed.draw(ch.context, width, height, true);
      width += processed.width;
    }
  }
}