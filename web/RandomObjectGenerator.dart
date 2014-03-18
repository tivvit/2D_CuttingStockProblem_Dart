import 'dart:math';
import 'Square.dart';

class RandomObjectGenerator {
  static int _maxSize = 50;
  static int _minSize = 10;
  static int _maxObjects = 20;
  static int _minObjects = 5;
  
  Set ObjectStorage; 
  
  RandomObjectGenerator(){
    ObjectStorage = new Set();
    
    var rng = new Random();
    
    for(int i = 0; i < _minObjects + rng.nextInt(_maxObjects - _minObjects); i++){
      ObjectStorage.add(generateSquare());
    }
  }
  
  Square generateSquare() {
    var rng = new Random();
    int size = _minSize + rng.nextInt(_maxSize - _minSize);
    return new Square(size);
  }
}