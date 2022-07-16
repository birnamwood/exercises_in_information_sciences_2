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

// 
void draw() {
  Mat src_mat = opencv.getColor();
  Mat dst_mat = new Mat();
  
  Mat skew_x_mat = new Mat(2, 3, CvType.CV_32F); // 行,列,型
  float [] tmpmat = {
    1.0, 0.0, 30.0,
    0.0, 1.0, 60.0
  };
  skew_x_mat.put(0, 0, tmpmat);
  Imgproc.warpAffine(src_mat, dst_mat, skew_x_mat, src_mat.size());
  PImage outImg = opencv.getSnapshot(dst_mat);
  image(outImg, 10, 10);
}
