// opencvパッケージのインポート
import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;

// 変数の宣言
OpenCV opencv;

// 初期設定
void setup() {
  // コンストラクタ(スケッチ, 画像ファイル, カラー画像)
  opencv = new OpenCV(this, "sample.png", true);
  // P2D = レンダラ
  size(500, 300, P2D);
  noLoop();
  frameRate(30);
}

// 例題3
void draw() {
  

// 例題2
//void draw() {
//  Mat src_mat = opencv.getColor();
//  Mat dst_mat = new Mat();
  
//  Imgproc.resize(src_mat, dst_mat, new Size(src_mat.width() * 0.7, src_mat.height() * 1.5));
//  PImage outImg = opencv.getSnapshot(dst_mat);
//  image(outImg, 10, 10);
//}

// 例題1
//void draw() {
//  opencv.flip(OpenCV.VERTICAL);
//  PImage outImg = opencv.getSnapshot();
//  image(outImg, 10, 10);
//}
