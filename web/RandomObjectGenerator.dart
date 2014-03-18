import 'dart:math';
import 'GraphicalObjects/Square.dart';
import 'GraphicalObjects/Circle.dart';

class RandomObjectGenerator {
  static int _maxSize = 50;
  static int _minSize = 10;
  static int _maxObjects = 20;
  static int _minObjects = 5;
  
  Set ObjectStorage; 
  
  RandomObjectGenerator(){
    ObjectStorage = new Set();
    
    var rng = new Random();
    
    for(int i = 0; i < RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generateSquare());
    }
    
    for(int i = 0; i <  RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generateCircle());
    }
  }
  
  Square generateSquare() {
    int size = RandomInt(_minSize, _maxSize);
    return new Square(size);
  }
  
  Circle generateCircle() {
    int r = RandomInt(_minSize, _maxSize);
    return new Circle(r);
  }
  
  int RandomInt(int min, int max) {
    var rng = new Random();
    return min + rng.nextInt(max - min);
  }
}