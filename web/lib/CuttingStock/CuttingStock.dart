library CuttingStock;

import 'dart:collection';
import 'dart:html';
import 'dart:math' as Math;
import '../CanvasHelper.dart';

import '../Graphics.dart' as GR;
import 'Cut.dart';

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
    if (a.width == b.width) {
      if(a.area() < b.area())
        return 1;
      if(a.area() == b.area())
        return 0;
      else
        return -1;
    }
    else
      return -1;
  }
  
  void solve(CanvasHelper ch) {
//    Map<double, Cut> cuts = new HashMap();
    List<Cut> cuts = new List();
    bool suitable = false;
    area = .0;
    unusedArea = .0;
    _ch = ch;
    _drawBoundingRect(ch.context, absoluteWidth, absoluteHeight);
    while(!queue.isEmpty) { 
      suitable = false;
      GR.GraphicalObject processed = queue.removeFirst();
      
      if(processed is GR.RotatableGraphicalObject) {
        if(processed.width > processed.height)
          processed.rotateLeft();
      }

      cuts.sort();
      
      var ci = cuts.iterator;
      while(ci.moveNext()) {
        //print(ci.current.area().toString());
        if(ci.current.isSuitable(processed.area().toDouble(), processed.width.toDouble(), processed.height.toDouble())){
          Cut cut = ci.current; 
          processed.draw(ch.context, cut.x.toInt(), cut.y.toInt(), true);
          cut.x += processed.width;
          cut.width -= processed.width;
          
          suitable = true;
          break;
        }
      }
      
      if(!suitable) { 
          //if(currentWidth+processed.width >= _width) {
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
         //}
          
          if(currentHeight+processed.height >= _height) {
              spaces++;
              
              addCut(ch.context, cuts, absoluteWidth.toDouble(), absoluteHeight+currentHeight.toDouble(), _width.toDouble(), _height-currentHeight.toDouble());
              
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
          
          max = Math.max(max, processed.height); 
          
          processed.draw(ch.context, absoluteWidth+currentWidth, absoluteHeight+currentHeight, true);
          
          currentWidth += processed.width;
          
          addCut(ch.context, cuts, absoluteWidth+currentWidth.toDouble(), absoluteHeight+currentHeight.toDouble(), _width-currentWidth.toDouble(), processed.height.toDouble());    
      }
      
      area += processed.area();
      unusedArea += processed.unusedArea();
      //todo openedArea (area of opened cuts)
          
      if(processed is GR.RotatableGraphicalObject) 
        processed.rotateBack();
    }
  }
  
  void addCut(CanvasRenderingContext2D context, List cuts, double x, double y, double width, double height){
    Cut c = new Cut(x, y, width, height);
    //c.draw(context);
    cuts.add(c);
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
    Stopwatch solveStopwatch = new Stopwatch()..start();
    defaultValues();
    addObjects(_objects);
    _ch.clear();
    solve(_ch);
    stats(_de);
    int solveTime = solveStopwatch.elapsed.inMilliseconds;
    querySelector("#solve").text = solveTime.toString();
  }
  
  void stats(DivElement de) {
    _de = de;
    de.innerHtml = "Spaces: <b>"+spaces.toString()+"</b>, area: <b>"+area.toStringAsFixed(2)+"</b>, unsable area: <b>"+unusedArea.toStringAsFixed(2)+"</b> unusable: <b>"+((unusedArea/area)*100).toStringAsFixed(1)+"%</b>";
  }
      
  void _drawBoundingRect(CanvasRenderingContext2D context,int x, int y) {        
     context.beginPath();
     context.rect(x-1, y-1, _width+2, _height+2);
//     context.fillStyle = 'red';
//     context.fill();
     context.strokeStyle = 'black';
     context.stroke();
     context.closePath();
  }
}