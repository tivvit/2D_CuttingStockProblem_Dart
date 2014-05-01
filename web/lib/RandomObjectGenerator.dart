import 'dart:math';
import 'Graphics.dart' as GR;

class RandomObjectGenerator {
  static int _maxSize = 50;
  static int _minSize = 20;
  static int _maxObjects = 20;
  static int _minObjects = 5;
  
  List ObjectStorage; 
  
  RandomObjectGenerator(){
    ObjectStorage = new List();
    
    var rng = new Random();
    
    for(int i = 0; i < RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generateSquare());
    }
    
    for(int i = 0; i <  RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generateCircle());
    }
    
    for(int i = 0; i <  RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generateTriangle());
    }
    
    for(int i = 0; i <  RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generateRectangle());
    }
  }
  
  
  //Object Factory
  GR.Square generateSquare() {
    int size = RandomInt(_minSize, _maxSize);
    return new GR.Square(size);
  }
  
  GR.Rectangle generateRectangle() {
      int a = RandomInt(_minSize, _maxSize);
      int b = RandomInt(_minSize, _maxSize);
      return new GR.Rectangle(a, b);
    }
  
  GR.Circle generateCircle() {
    int r = (RandomInt(_minSize, _maxSize)/2).round();
    return new GR.Circle(r);
  }
  
  GR.Triangle generateTriangle() {
      int a = RandomInt(_minSize, _maxSize);
      int b = RandomInt(_minSize, _maxSize);
      int c = RandomInt(_minSize, a+b); //a+b to satisfy triangle nonquality
      return new GR.Triangle(a,b,c);
  }
  
  int RandomInt(int min, int max) {
    var rng = new Random();
    return min + rng.nextInt(max - min);
  }
}