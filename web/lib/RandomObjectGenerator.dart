import 'dart:math';
import 'Graphics.dart' as GR;

class RandomObjectGenerator {
  int _maxSize = 50;
  int _minSize = 20;
  int _maxObjects = 40;
  int _minObjects = 10;
  
  List ObjectStorage;
  
  RandomObjectGenerator(this._minObjects, this._maxObjects, this._minSize, this._maxSize);
  
  void generate(){
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
    
    for(int i = 0; i <  RandomInt(_minObjects, _maxObjects); i++){
      ObjectStorage.add(generatePoly());
    }
  }
  
  
  //Object Factories
  GR.Square generateSquare() {
    int size = RandomInt(_minSize, _maxSize);
    return new GR.Square(size);
  }
  
  GR.Rectangle generateRectangle() {
      int a = RandomInt(_minSize, _maxSize ~/ 1.20);
      int b = RandomInt((a *.8).toInt(), _maxSize);
      return new GR.Rectangle(a, b);
    }
  
  GR.Circle generateCircle() {
    int r = (RandomInt(_minSize, _maxSize)/2).round();
    return new GR.Circle(r);
  }
  
  GR.Triangle generateTriangle() {
      int a = RandomInt(_minSize, _maxSize);
      int b = RandomInt(_minSize, _maxSize);
      int c = RandomInt(_minSize, min((a+b),_maxSize)); //a+b to satisfy triangle nonquality
      return new GR.Triangle(a,b,c);
  }
  
  GR.PolyObject generatePoly() {
        int a = RandomInt(_minSize, _maxSize ~/ 2);
        int b = RandomInt(_minSize+10, _maxSize);
        int c = RandomInt(_minSize, _maxSize ~/ 2);
        int d = RandomInt(10, b);
        int e = RandomInt(0, b-d);
        return new GR.PolyObject(a,b,c,d,e);
    }
  
  int RandomInt(int min, int max) {
    var rng = new Random();
    return min + rng.nextInt(max - min);
  }
}