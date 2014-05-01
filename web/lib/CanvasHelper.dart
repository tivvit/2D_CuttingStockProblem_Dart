library CanvasHelper;

import 'dart:html';

class CanvasHelper {
  CanvasRenderingContext2D context;
  
  CanvasHelper(String element) {
    CanvasElement canvas = querySelector(element);
    context = canvas.getContext('2d');
  }
  
  void clear() {
    context.beginPath();
    context.clearRect(0,0,context.canvas.width,context.canvas.width);
    context.fillStyle = '#ffffff';
    context.strokeStyle = '#000000';
    context.fillRect(0,0,context.canvas.width,context.canvas.width);
  }
}