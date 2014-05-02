library CuttingStock;

import 'dart:collection';
import 'dart:html';
import 'dart:math' as Math;
import '../CanvasHelper.dart';

import '../Graphics.dart' as GR;

class CuttingStock {  
  static int width = 150, height = 150, offset = 10;
  int currentWidth = 0, currentHeight = 0, max = 0, spaces = 1, absoluteWidth = offset, absoluteHeight = offset;
  double area = .0, unusedArea = .0, openedArea = .0; 
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
    _drawBoundingRect(ch.context, absoluteWidth, absoluteHeight);
    while(!queue.isEmpty) {   
      GR.GraphicalObject processed = queue.removeFirst();
      
      if(processed.name == "Triangle" || processed.name == "Rectangle")
              processed.rotateLeft();
      
      if(currentWidth+processed.width >= width) {
            currentHeight += max;
            
            /*if(currentHeight >= height) {
              spaces++;
              currentHeight = 0; 
              absoluteWidth += width+offset;
              absoluteHeight = offset;
              drawBoundingRect(ch.context, absoluteWidth, absoluteHeight);
            }*/
            
            currentWidth = 0;
            max = 0;
     }
      
      if(currentHeight+processed.height >= height) {
                    spaces++;
                    currentHeight = 0; 
                    absoluteWidth += width+offset;
                    absoluteHeight = offset;
                    _drawBoundingRect(ch.context, absoluteWidth, absoluteHeight);
                    currentWidth = 0;
                                max = 0;
     }
      
      //canvas height solution
          
      max = Math.max(max, processed.height); 
      
      processed.draw(ch.context, absoluteWidth+currentWidth, absoluteHeight+currentHeight, true);
      area += processed.area();
      unusedArea += processed.unusedArea();
      //todo openedArea (area of opened cuts)
      currentWidth += processed.width;
    }
  }
  
  void _drawBoundingRect(CanvasRenderingContext2D context,int x, int y) {        
     context.beginPath();
     context.rect(x-1, y-1, width+2, height+2);
     
     //todo barvi cuty
     
     context.fillStyle = 'red';
     context.fill();
     context.stroke();
     context.closePath();
  }
}