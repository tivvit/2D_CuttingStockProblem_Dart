import 'dart:html';
import 'dart:math' as Math;

import 'lib/RandomObjectGenerator.dart';
import 'lib/CanvasHelper.dart';
import 'lib/CuttingStock/CuttingStock.dart';

int width = 120, height = 120;
int minObjects = 10, maxObjects = 40, minSize = 20, maxSize = 50;
CuttingStock cs = new CuttingStock(width, height);

  
void main() {
  createNewProblem();
  
//  querySelector("#refresh")
//      ..onClick.listen(refresh);
  
  querySelectorAll("input.sizes")
      ..onChange.listen(valueChange);
  
  querySelectorAll("input.settings")
      ..onChange.listen(settingsChange);
  
}

void settingsChange(Event event) {
  InputElement ie = event.target;
    try {
      int i = int.parse(ie.value);
      if(i >= 1 && i <= 200) {
        bool ex = false;
         switch(ie.name) {
           case "minObjects":
             if(i < maxObjects)
                minObjects = i;
             else
               ex = true;
             break;
           case 'maxObjects':
             if(i > minObjects)
                maxObjects = i;
             else
                ex = true;
             break;
           case 'minSize':
             if(i < maxSize)
                minSize = i;
             else
                ex = true;
             break;
           case 'maxSize':
             if(i > minSize)
                maxSize = i;
             else
                ex = true;
             break;
         }
         
         if(ex){
           window.alert("min has to be smaller and max bigger");
           settingsBack(ie);
         }
      }
      else {
        window.alert("sorry value has to be between 1 and 200");
        settingsBack(ie);
    }
  }
  catch(e) {
    window.alert("NaN");
    settingsBack(ie);
  }    
  createNewProblem();
}

void settingsBack(InputElement ie) {
  switch(ie.name) {
     case "minObjects":
       ie.value = minObjects.toString();
       break;
     case 'maxObjects':
       ie.value = maxObjects.toString();
       break;
     case 'minSize':
       ie.value = minSize.toString();
        break;
     case 'maxSize':
       ie.value = maxSize.toString();
        break;
   }
}

void valueChange(Event event) {
  InputElement ie = event.target;
  try {
    int i = int.parse(ie.value);
    if(i > maxSize) {
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
      window.alert(maxSize.toString()+" is minimal allowed value");
      
      if(ie.name == "width")
            ie.value = width.toString();
      else
            ie.value = height.toString();
    }
  }
  catch(e) {
    window.alert("NaN");
    cs.width = width;
    cs.height = height;
    if(ie.name == "width")
      ie.value = width.toString();
    else
      ie.value = height.toString();
  }    
}

void createNewProblem() {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  
  RandomObjectGenerator rog = new RandomObjectGenerator(minObjects, maxObjects, minSize, maxSize);
  rog.generate();
  
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
  cs.solve(csCanvas);
  
  var a = querySelector("#stats");
  cs.stats(a);
}
