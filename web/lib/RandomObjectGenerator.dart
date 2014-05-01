import 'dart:math';
import 'Graphics.dart';

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
  }
  
  
  //Object Factory
  Square generateSquare() {
    int size = RandomInt(_minSize, _maxSize);
    return new Square(size);
  }
  
  Circle generateCircle() {
    int r = RandomInt(_minSize, _maxSize);
    return new Circle(r);
  }
  
  Triangle generateTriangle() {
      int a = RandomInt(_minSize, _maxSize);
      int b = RandomInt(_minSize, _maxSize);
      int c = RandomInt(_minSize, a+b); //a+b to satisfy triangle nonquality
      return new Triangle(a,b,c);
  }
  
  int RandomInt(int min, int max) {
    var rng = new Random();
    return min + rng.nextInt(max - min);
  }
}