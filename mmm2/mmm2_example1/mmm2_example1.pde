import gab.opencv.*;
OpenCV opencv;
void setup(){
 opencv = new OpenCV(this, "sample.png", true); //(1)

 size(800, 500, P2D);
 noLoop();
}

// ヒストグラムの描写
void draw(){
 background(0);

 // 画像のヒストグラムを取得している
 Histogram grayHist = opencv.findHistogram( opencv.gray(opencv.getColor()), 256 ); //(2)
 Histogram rHist = opencv.findHistogram( opencv.getR(), 256 ); //(3)
 Histogram gHist = opencv.findHistogram( opencv.getG(), 256 ); //(4)
 Histogram bHist = opencv.findHistogram( opencv.getB(), 256 ); //(5)

 PImage in_img = opencv.getInput(); //(6)
 image(in_img, 300, 10);

 // グレーヒストグラムの枠
 stroke(127); //(7)
 noFill();
 rect(20, 10, 256, 100);
 // グレーのヒストグラムを描写
 fill(127); //(8)
 noStroke(); //(9)
 grayHist.draw(20, 10, 256, 100); //
 // 赤色
 stroke(255, 0, 0); //(10)
 noFill();
 rect(20, 20+100, 256, 100);
 fill(255, 0, 0);
 noStroke();
 rHist.draw(20, 20+100, 256, 100); //(11)
 // 緑色
 stroke(0, 255, 0); //(12)
 noFill();
 rect(20, 30+200, 256, 100);
 fill(0, 255, 0);
 noStroke();
 gHist.draw(20, 30+200, 256, 100); //(13)
 // 青色
 stroke(0, 0, 255); //(14)
 noFill();
 rect(20, 40+300, 256, 100);
 fill(0, 0, 255);
 noStroke();
 bHist.draw(20, 40+300, 256, 100); //(15)
}
