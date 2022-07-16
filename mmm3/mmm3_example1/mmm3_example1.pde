import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;
import processing.video.*;
Movie video;
OpenCV opencv;
int WIDTH = 640;
int HEIGHT = 480;
void setup(){
 size(640, 480);
 video = new Movie(this, "utty_sample.mp4");
 opencv = new OpenCV(this, WIDTH, HEIGHT);
 video.loop();
 video.play();
}
void draw(){
  if(video.width<10 || video.height<10){
    return;
  }
 opencv.loadImage(video);
 opencv.useColor();
 opencv.flip(OpenCV.HORIZONTAL); //反転

 PImage img = opencv.getSnapshot();
 image(img, 0, 0);
}
void movieEvent(Movie m){
 m.read();
}
