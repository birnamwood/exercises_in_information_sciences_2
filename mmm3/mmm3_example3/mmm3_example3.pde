import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;
import processing.video.*;
Movie video;
OpenCV opencv;
int WIDTH = 640;
int HEIGHT = 480;
int Hmin = 40;
int Hmax = 90;
Mat mask_mat;
Mat out_mat;

void setup(){
 size(1280, 480);
 video = new Movie(this, "utty_sample.mp4");
 opencv = new OpenCV(this, WIDTH, HEIGHT);
 video.loop();
 video.play();
 mask_mat = new Mat(HEIGHT, WIDTH, CvType.CV_8U);
 out_mat = new Mat();
}

void draw(){
 if(video.width<10 || video.height<10){
   return;
 }
 opencv.loadImage(video);
 opencv.useColor();


 Mat bgr_mat_in = opencv.getColor();
 Mat hsv_mat_in = new Mat();
 Imgproc.cvtColor(bgr_mat_in, hsv_mat_in, Imgproc.COLOR_BGR2HSV);
 ArrayList<Mat> hsv_mat_list = new ArrayList<Mat>();
 Core.split(hsv_mat_in, hsv_mat_list);
  //マスク画像の生成
 for (int x = 0; x < bgr_mat_in.rows(); x++){
 for (int y = 0; y < bgr_mat_in.cols(); y++){
 double tmp_hsv_val = hsv_mat_list.get(0).get(x, y)[0];
 if ( Hmin <= tmp_hsv_val && tmp_hsv_val <= Hmax){
 mask_mat.put(x, y, 0);
 }
 else {
 mask_mat.put(x, y, 255);
 }
 }
 }

 //※膨張・収縮処理 (11)〜(14) (発展的な課題 1 で追加)

 out_mat.setTo(Scalar.all(255));
 bgr_mat_in.copyTo(out_mat, mask_mat);
 PImage in_img = opencv.getInput();
 PImage out_img = opencv.getSnapshot(out_mat);
 image(in_img, 0, 0);
 image(out_img, in_img.width, 0);
}

void movieEvent(Movie m){
 m.read();
}
