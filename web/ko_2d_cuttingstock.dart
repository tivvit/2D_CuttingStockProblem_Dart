import 'dart:html';
import 'dart:math' as Math;

import 'lib/RandomObjectGenerator.dart';
import 'lib/CanvasHelper.dart';
import 'lib/CuttingStock/CuttingStock.dart';

int width = 150;
int height = 150;
CuttingStock cs = new CuttingStock(width, height);
  
void main() {
  createNewProblem();
  
  querySelector("#refresh")
      ..onClick.listen(refresh);
  
  querySelectorAll("input.sizes")
      ..onChange.listen(valueChange);
  
}

void valueChange(Event event) {
  InputElement ie = event.target;
  if(int.parse(ie.value) is num) {
    int i = int.parse(ie.value);
    if(i > 50) {
     if(ie.name == "width") {
        cs.width = i;
        width = i;
     }
     else {
        cs.height = i;
        height = i;
     }
    }
    else {
      window.alert("50 is minimum");
      
      if(ie.name == "width")
            ie.value = width.toString();
      else
            ie.value = height.toString();
    }
  }
  else {
    window.alert("NaN");
    cs.width = width;
    cs.height = height;
    if(ie.name == "width")
      ie.value = width.toString();
    else
      ie.value = height.toString();
  }    
}

void refresh(MouseEvent event) {
  createNewProblem();
}

void createNewProblem() {
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
  
  cs.defaultValues();  
  cs.addObjects(rog.ObjectStorage);
  cs.draw(csCanvas);
  
  var a = querySelector("#stats");
  cs.stats(a);
}
