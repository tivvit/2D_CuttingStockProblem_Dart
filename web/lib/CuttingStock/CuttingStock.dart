library CuttingStock;

import 'dart:collection';
import 'dart:html';
import 'dart:math' as Math;
import '../CanvasHelper.dart';

import '../Graphics.dart' as GR;

class CuttingStock {  
  static int offset = 10;
  int currentWidth = 0, currentHeight = 0, max = 0, spaces = 1, _width = 150, _height = 150, absoluteWidth = offset, absoluteHeight = offset;
  double area = .0, unusedArea = .0, openedArea = .0; 
  Queue<GR.GraphicalObject> queue = new Queue();
  CanvasHelper _ch;
  List _objects;
  DivElement _de;
  
  CuttingStock(this._width, this._height);
  
  void defaultValues() {
    currentWidth = 0;
    currentHeight = 0;
    max = 0;
    spaces = 1;
    absoluteWidth = offset;
    absoluteHeight = offset;
  }
  
  void addObjects(List objects) {
    _objects = objects;
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
    _ch = ch;
    _drawBoundingRect(ch.context, absoluteWidth, absoluteHeight);
    while(!queue.isEmpty) {   
      GR.GraphicalObject processed = queue.removeFirst();
      
      if(processed is GR.RotatableGraphicalObject) 
              processed.rotateLeft();
      
      if(currentWidth+processed.width >= _width) {
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
      
      if(currentHeight+processed.height >= _height) {
                    spaces++;
                    currentHeight = 0; 
                    absoluteWidth += _width+offset;
                    if(absoluteWidth+_width > ch.canvas.width) {
                      absoluteWidth = offset; 
                      absoluteHeight = absoluteHeight+_height+offset; 
                    }
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
  
  void set width(int x){
    _width = x;
    redraw();
  } 
  
  void set height(int x){
    _height = x;
    redraw();
  } 
  
  void redraw() {
    defaultValues();
    addObjects(_objects);
    _ch.clear();
    draw(_ch);
    stats(_de);
  }
  
  void stats(DivElement de) {
    _de = de;
    de.text = "Spaces: "+spaces.toString()+", area: "+area.toStringAsFixed(2)+", unused area: "+unusedArea.toStringAsFixed(2)+" unused%: "+((unusedArea/area)*100).toStringAsFixed(1)+"%";
  }
      
  void _drawBoundingRect(CanvasRenderingContext2D context,int x, int y) {        
     context.beginPath();
     context.rect(x-1, y-1, _width+2, _height+2);
     
     //todo barvi cuty
     
     context.fillStyle = 'red';
     context.fill();
     context.stroke();
     context.closePath();
  }
}