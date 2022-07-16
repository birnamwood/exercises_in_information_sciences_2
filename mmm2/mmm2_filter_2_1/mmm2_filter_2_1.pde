import gab.opencv.*;
import org.opencv.imgproc.*; //(1)
import org.opencv.core.*; //(2)
OpenCV opencv;

void setup(){
 opencv = new OpenCV(this, "sample.png", true);
 size(800, 250, P2D);
 noLoop();
}

void draw(){
 Mat src_mat = opencv.getColor(); //(3)
 Mat dst_mat = new Mat(); //(4)

 // 3x3の空間フィルタとして用いる
 Mat kernel = new Mat(3, 3, CvType.CV_32F); //(5)
 // 空間フィルタ用配列 鮮鋭化 2方向
 float [] tmpkernel = { //(6)
  0.0, -1.0, 0.0,
  -1.0, 5.0, -1.0,
  0.0, -1.0, 0.0
 };
 // Matオブジェクトに数値配列を代入
 kernel.put(0, 0, tmpkernel); //(7)
 // フィルタ処理を行う
 Imgproc.filter2D(src_mat, dst_mat, src_mat.type(), kernel); //(8)
  //
 PImage in_img = opencv.getInput(); //(9)
 // dst_matがmat型のためgetSnapshotで取得
 PImage out_img = opencv.getSnapshot(dst_mat); //(10)
 image(in_img, 0, 0);
 image(out_img, in_img.width, 0);
}
