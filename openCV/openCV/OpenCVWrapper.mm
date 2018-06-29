//
//  OpenCVWrapper.m
//  openCV
//
//  Created by inf on 2018/06/01.
//  Copyright © 2018年 kent. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgcodecs/ios.h>//これがないとUIImageToMatとかが使えない

#import "OpenCVWrapper.h"

//Camera用
@interface OpenCVWrapper()<CvVideoCameraDelegate>{
    CvVideoCamera *cvCamera;
}
@end


@implementation OpenCVWrapper

//ToGray
-(UIImage *)toGray:(UIImage *)input_img {
    cv::Mat gray_img;                               // 変換用Matの宣言
    UIImageToMat(input_img, gray_img);              //---②引数のinput_imgをcv::Mat型のgray_imgへ変換
    cv::cvtColor(gray_img, gray_img, CV_BGR2GRAY);  //---③gray_imgをRGB画像からグレースケール画像へ変換
    input_img = MatToUIImage(gray_img);             //---④cv::Mat型からUIImage型へ変換し，input_imgへ入れる

    return input_img;
}

//Cameraの初期設定用メソッド
- (void)createCameraWithParentView:(UIImageView*)parentView{
    cvCamera =[[CvVideoCamera alloc]initWithParentView:parentView];
    
    cvCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    cvCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    cvCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    cvCamera.defaultFPS = 20;
    cvCamera.grayscaleMode = false;
    cvCamera.delegate = self;
}
//Camera スタート
- (void)start{
    [cvCamera start];
}
//Cameraデリゲートメソッド ここにカメラ用の処理を入れる
- (void)processImage:(cv::Mat &)image{
    //Do some OpenCV stuff with image
    cv::Mat image_copy;
    cvtColor(image, image_copy, CV_BGRA2BGR);
    
    //invert image
    bitwise_not(image_copy, image_copy);
    cvtColor(image_copy, image, CV_BGRA2BGR);
}

@end
