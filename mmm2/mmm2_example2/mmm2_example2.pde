import gab.opencv.*;
OpenCV opencv;
void setup(){
 opencv = new OpenCV(this, "sample.png", true);
 size(800, 250, P2D);
 noLoop();
}

void draw(){
 //--blur 引数3で、3x3のマスクで処理される
 opencv.blur(3); //(1)

 PImage in_img = opencv.getInput(); //(2)
 PImage out_img = opencv.getOutput(); //(3)
 image(in_img, 0, 0); //(4)
 image(out_img, in_img.width, 0); //(5)
}
