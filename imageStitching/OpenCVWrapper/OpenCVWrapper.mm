//
//  OpenCVWrapper.m
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

#import "OpenCVWrapper.h"
#include <opencv2/opencv2.h>
#include <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper
+(UIImage *) detectEdge:(UIImage *)image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    if (imageMat.channels() == 1) {
        return image;
    }
    
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, cv::COLOR_BGR2GRAY);
    
    cv::Mat cannyMat;
    cv::Canny(grayMat, cannyMat, 50, 150, 3);
    
    return MatToUIImage(cannyMat);
}

@end
