import 'dart:html';
import 'dart:math' as Math;

import 'lib/RandomObjectGenerator.dart';
import 'lib/CanvasHelper.dart';
import 'lib/CuttingStock/CuttingStock.dart';

void main() {
  querySelector("#sample_text_id")
      ..text = "Refresh!"
      ..onClick.listen(reverseText);
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  
  RandomObjectGenerator rog = new RandomObjectGenerator();
  
  rog.ObjectStorage.forEach(
      (elem) => buffer..write(elem.toString())
                      ..write(", ")
  );

  querySelector("#sample_text_id").text = buffer.toString();
  
  CanvasHelper ch = new CanvasHelper('#canvas');
  ch.clear();
      
  int offset = 5, width = offset, height = offset, max = 0; 
  String last;
  
  for(int i = 0; i < rog.ObjectStorage.length-1;i++){
    var go = rog.ObjectStorage.elementAt(i);
    //print(go.class.toString());
    if(go.name != last) {
      //print(max);
      height += max+offset;
      width = offset;
      max = 0;
      last = go.name;
    }
    
    max = Math.max(max, go.height); 
   
    go.draw(ch.context, width, height);
    width += go.width + offset;
  }
  
  CanvasHelper csCanvas = new CanvasHelper('#cuttingStock');
  csCanvas.clear();
  
  CuttingStock cs = new CuttingStock();
  cs.addObjects(rog.ObjectStorage);
  cs.draw(csCanvas);
  
  querySelector("#stats").text = "Spaces: "+cs.spaces.toString()+", area: "+cs.area.toStringAsFixed(2)+", unused area: "+cs.unusedArea.toStringAsFixed(2)+" unused%: "+((cs.unusedArea/cs.area)*100).toStringAsFixed(1)+"%";
}
