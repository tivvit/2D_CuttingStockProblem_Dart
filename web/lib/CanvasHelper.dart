library CanvasHelper;

import 'dart:html';

class CanvasHelper {
  CanvasRenderingContext2D context;
  CanvasElement canvas;
  
  CanvasHelper(String element) {
    canvas = querySelector(element);
    context = canvas.getContext('2d');
    context.lineJoin = 'miter';
    context.lineCap = 'butt';
    context.strokeStyle = 'black';
    context.lineWidth = 1;
  }
  
  void clear() {
    context.beginPath();
    context.clearRect(0,0,context.canvas.width,context.canvas.width);
    context.fillStyle = '#ffffff';
    context.strokeStyle = '#000000';
    context.fillRect(0,0,context.canvas.width,context.canvas.width);
    context.closePath();
  }
}