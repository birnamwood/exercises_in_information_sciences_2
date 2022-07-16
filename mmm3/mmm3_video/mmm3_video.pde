import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;
import processing.video.*;
import controlP5.*;

// 定義
Movie video;
OpenCV opencv;
PImage bg_img;

int WIDTH = 640;
int HEIGHT = 480;
int Hmin = 40;
int Hmax = 90;
Mat mask_mat;
Mat out_mat;
int imageYPos = 100;

ControlP5 cp5;
int slider1;

// 初期化
void setup(){
 size(1280, 680);
 cp5 = new ControlP5(this);
 cp5.addSlider("slider1")
   .setPosition(50,0)
   .setSize(200,50)
   .setRange(0,255)
   .setValue(50);
 text("(設定した数値±20でマスク画像を作成)", 300, 30);
   
 video = new Movie(this, "utty_sample.mp4");
 opencv = new OpenCV(this, WIDTH, HEIGHT);
 video.loop();
 video.play();
 mask_mat = new Mat(HEIGHT, WIDTH, CvType.CV_8U); // Mask画像用
 out_mat = new Mat(); // 結果用
 bg_img = loadImage("background.png"); // 背景
}

// 描写
void draw(){
  // videoが読み込めなかった場合の処置
  if(video.width<10 || video.height<10){
    return;
  }
  opencv.loadImage(video); // videoをopenCVに読み込む
  opencv.useColor();  // カラー画像として使用

  Mat bgr_mat_in = opencv.getColor();  // フレーム画像を Mat 型データに変換する(RGB カラー)
  Mat hsv_mat_in = new Mat(); // HSV 型にした画像データを保存する変数
  Imgproc.cvtColor(bgr_mat_in, hsv_mat_in, Imgproc.COLOR_BGR2HSV); // HSV 型に変換する
  ArrayList<Mat> hsv_mat_list = new ArrayList<Mat>(); // 色相/彩度/明度を分けて保存する変数
  Core.split(hsv_mat_in, hsv_mat_list); // HSV データを色相/彩度/明度に分けて Mat 型に保存
  
  // マスク画像の生成
  for (int x = 0; x < bgr_mat_in.rows(); x++){
    for (int y = 0; y < bgr_mat_in.cols(); y++){
      double tmp_hsv_val = hsv_mat_list.get(0).get(x, y)[0]; // 色相の取り出し
      if ( slider1 - 20 <= tmp_hsv_val && tmp_hsv_val <= slider1 + 20){
             //if ( Hmin <= tmp_hsv_val && tmp_hsv_val <= Hmax){
        mask_mat.put(x, y, 0); // 色相が指定した範囲内(緑)なら対応するドットに0を指定
      } else {
        mask_mat.put(x, y, 255);  // ドットに255を設定
      }
    }
  }

  //※膨張・収縮処理
  for (int i = 0; i < 3; i++){ // 3回処理
    Imgproc.dilate(mask_mat, mask_mat, new Mat()); // dilateメソッドで膨張処理
  }
  for (int i = 0; i < 3; i++){ // 3回
    Imgproc.erode(mask_mat, mask_mat, new Mat()); // erodeメソッドで収縮処理
  }
 
  out_mat.setTo(Scalar.all(0)); // 黒で埋める
  bgr_mat_in.copyTo(out_mat, mask_mat); // 埋めたところに取り出したマスク画像をセット
  
  PImage in_img = opencv.getInput();
  PImage out_img = opencv.getSnapshot(out_mat);
  image(in_img, 0, imageYPos);
  image(bg_img, in_img.width, imageYPos); // 背景を表示
  image(out_img, in_img.width, imageYPos); // 処理した画像を表示
}

void movieEvent(Movie m){
 m.read();
}
