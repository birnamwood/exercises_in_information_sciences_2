import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;
import processing.video.*;
Movie video;
OpenCV opencv;
int WIDTH = 640;
int HEIGHT = 480;
void setup(){
 size(1280, 480);
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

 Mat bgr_mat_in = opencv.getColor(); //(1)フレーム画像を Mat 型データに変換する(RGB カラー)
 Mat hsv_mat_in = new Mat(); //(2)HSV 型にした画像データを保存する変数
 Imgproc.cvtColor(bgr_mat_in, hsv_mat_in, Imgproc.COLOR_BGR2HSV); //(3)HSV 型に変換する
 ArrayList<Mat> hsv_mat_list = new ArrayList<Mat>(); //(4)色相/彩度/明度を分けて保存する変数
 Core.split(hsv_mat_in, hsv_mat_list); //(5)HSV データを色相/彩度/明度に分けて Mat 型に保存

 hsv_mat_list.get(0).setTo(Scalar.all(20.0)); //(6)HSV データの色相を全て 20.0 に設定
 hsv_mat_list.get(1).setTo(Scalar.all(64.0)); //(7)HSV データの彩度を全て 64.0 に設定

 Mat hsv_mat_out = new Mat(); //(8)HSV 型のデータ(処理結果)を保存する変数を生成
 Core.merge(hsv_mat_list, hsv_mat_out); //(9)色相/彩度/明度に分かれていた画像を統合
 Mat bgr_mat_out = new Mat(); //(10)RGB 型のデータ(処理結果)を保存する変数を生成
 Imgproc.cvtColor(hsv_mat_out, bgr_mat_out, Imgproc.COLOR_HSV2BGR); //(11)HSV->RGB に変換

 PImage in_img = opencv.getInput();
 PImage out_img = opencv.getSnapshot(bgr_mat_out);
 image(in_img, 0, 0);
 image(out_img, in_img.width, 0);
}

void movieEvent(Movie m){
 m.read();
}
