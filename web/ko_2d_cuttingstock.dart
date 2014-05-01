import 'dart:html';
import 'dart:math' as Math;

import 'lib/RandomObjectGenerator.dart';
import 'lib/CanvasHelper.dart';

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
    
    max = Math.max(max, go.size); 
   
    go.draw(ch.context, width, height);
    width += go.size + offset;
  }
}
