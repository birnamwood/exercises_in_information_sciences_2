// opencvパッケージのインポート
import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;

// 変数の宣言
OpenCV opencv;
//float angle = -45.0;
//float scale = 1.0;

// 初期設定
void setup() {
  // コンストラクタ(スケッチ, 画像ファイル, カラー画像)
  opencv = new OpenCV(this, "sample.png", true);
  // P2D = レンダラ
  size(500, 300, P2D);
  noLoop();
  frameRate(30);
}

// 例題4 スキュー
void draw() {
  Mat src_mat = opencv.getColor();
  Mat dst_mat = new Mat();
  
  Mat skew_x_mat = new Mat(2, 3, CvType.CV_32F); // 行,列,型
  float [] tmpmat = {
    1.0, -0.5, 0.0,
    0.0, 1.0, 0.0
  };
  skew_x_mat.put(0, 0, tmpmat);
  Imgproc.warpAffine(src_mat, dst_mat, skew_x_mat, src_mat.size());
  PImage outImg = opencv.getSnapshot(dst_mat);
  image(outImg, 10, 10);
}

// 例題3 回転
//void draw() {
//  Mat src_mat = opencv.getColor();
//  Mat dst_mat = new Mat();
  
//  Point center = new Point(src_mat.cols() / 2, src_mat.rows() / 2);
//  Mat affine_matrix = Imgproc.getRotationMatrix2D(center, angle, scale);
//  Imgproc.warpAffine(src_mat, dst_mat, affine_matrix, src_mat.size());
//  PImage outImg = opencv.getSnapshot(dst_mat);
//  image(outImg, 10, 10);  
//}
  
// 例題2 拡大　縮小
//void draw() {
//  Mat src_mat = opencv.getColor();
//  Mat dst_mat = new Mat();
  
//  Imgproc.resize(src_mat, dst_mat, new Size(src_mat.width() * 0.7, src_mat.height() * 1.5));
//  PImage outImg = opencv.getSnapshot(dst_mat);
//  image(outImg, 10, 10);
//}

// 例題1 反転
//void draw() {
//  opencv.flip(OpenCV.VERTICAL);
//  PImage outImg = opencv.getSnapshot();
//  image(outImg, 10, 10);
//}
