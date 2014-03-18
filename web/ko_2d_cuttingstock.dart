import 'dart:html';
import 'RandomObjectGenerator.dart';
import 'CanvasHelper.dart';

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
      (elem) => buffer.write(elem.toString()+", ")
  );

  querySelector("#sample_text_id").text = buffer.toString();
  
  CanvasHelper ch = new CanvasHelper('#canvas');
  ch.clear();
      
  int width = 5;  
      
  for(int i = 0; i < rog.ObjectStorage.length-1;i++){
    var go = rog.ObjectStorage.elementAt(i);
    go.draw(ch.context, width);
    width += go.a + 5;
  }  
}
