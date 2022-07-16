import gab.opencv.*;
import org.opencv.imgproc.*;
import org.opencv.core.*;
OpenCV opencv;
float angle = -45.0f;

void setup(){
 opencv = new OpenCV(this, "sample.png", true);
 size(1500, 300, P2D);
 noLoop();
 frameRate(30);
}

void draw(){
 Mat src_mat = opencv.getColor();
 Mat dst_mat1 = new Mat();
 Mat dst_mat2 = new Mat();
 Mat dst_mat3 = new Mat();

 float tx = src_mat.cols() / 2.0f;
 float ty = src_mat.rows() / 2.0f;

 float tmpcos = (float)Math.cos(Math.PI*(angle/180.0f));
 float tmpsin = (float)Math.sin(Math.PI*(angle/180.0f));
 float [] tmpmat1 = {
 1.0, 0.0, -tx ,
 0.0, 1.0, -ty
 };
 float [] tmpmat2 = {
 tmpcos, -tmpsin, 0.0,
 tmpsin, tmpcos, 0.0
 };
  float [] tmpmat3 = {
 1.0, 0.0, tx,
 0.0, 1.0, ty
 };

 Mat affine_mat = new Mat(2, 3, CvType.CV_32F); //アフィンマトリックス
 affine_mat.put(0, 0, tmpmat1);
 Imgproc.warpAffine(src_mat, dst_mat1, affine_mat, src_mat.size()); //原点への平行移動
 affine_mat.put(0, 0, tmpmat2); //(20)
 Imgproc.warpAffine(dst_mat1, dst_mat2, affine_mat, src_mat.size()); //原点周りの回転
 affine_mat.put(0, 0, tmpmat3); //(20)
 Imgproc.warpAffine(dst_mat2, dst_mat3, affine_mat, src_mat.size()); //元の位置へ平行移動
 PImage outImg = opencv.getSnapshot(dst_mat1);
 image(outImg, 10, 10);
 outImg = opencv.getSnapshot(dst_mat1); //原点へ平行移動
 image(outImg, 10, 10);
 outImg = opencv.getSnapshot(dst_mat2); //原点周りの回転
 image(outImg, 510, 10);
 outImg = opencv.getSnapshot(dst_mat3); //元の位置へ平行移動
 image(outImg, 1010, 10);
}
 

// list 5

//import gab.opencv.*;
//import org.opencv.imgproc.*;
//import org.opencv.core.*;
//OpenCV opencv;
//float angle = -45.0f; //(1)
//void setup(){
// opencv = new OpenCV(this, "sample.png", true);
// size(500, 300, P2D);
// noLoop();
//frameRate(30);
//}
//void draw(){
// Mat src_mat = opencv.getColor();
// Mat dst_mat = new Mat();

// float tx = src_mat.cols() / 2.0f; //(2)
// float ty = src_mat.rows() / 2.0f; //(3)

// Mat mat1 = new Mat(3, 3, CvType.CV_32F); //(4)
// Mat mat2 = new Mat(3, 3, CvType.CV_32F); //(5)
// Mat mat3 = new Mat(3, 3, CvType.CV_32F); //(6)
// float tmpcos = (float)Math.cos(Math.PI*(angle/180.0f)); //(7)
// float tmpsin = (float)Math.sin(Math.PI*(angle/180.0f)); //(8)
// float [] tmpmat1 = { //(9)
// 1.0, 0.0, -tx ,
// 0.0, 1.0, -ty,
// 0.0, 0.0, 1.0
// };
// float [] tmpmat2 = { //(10)
// tmpcos, -tmpsin, 0.0,
// tmpsin, tmpcos, 0.0,
// 0.0, 0.0, 1.0
// };
// float [] tmpmat3 = { //(11)
// 1.0, 0.0, tx,
// 0.0, 1.0, ty,
// 0.0, 0.0, 1.0
// };
// mat1.put(0, 0, tmpmat1); //(12)
// mat2.put(0, 0, tmpmat2); //(13)
// mat3.put(0, 0, tmpmat3); //(14)

// Mat mat21 = new Mat(3, 3, CvType.CV_32F); //(15)
// Core.gemm( mat2, mat1, 1.0, new Mat(), 0.0, mat21); //(16)
// Mat mat321 = new Mat(3, 3, CvType.CV_32F); //(17)
// Core.gemm(mat3, mat21, 1.0, new Mat(), 0.0, mat321); //(18)

// Mat affine_mat = new Mat(2, 3, CvType.CV_32F); //(19)
// affine_mat = mat321.submat(0, 2, 0, 3); //(20)

// Imgproc.warpAffine(src_mat, dst_mat, affine_mat, src_mat.size()); //(21)
// PImage outImg = opencv.getSnapshot(dst_mat);
// image(outImg, 10, 10);
//}
