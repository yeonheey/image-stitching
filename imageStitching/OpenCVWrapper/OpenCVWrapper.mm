//
//  OpenCVWrapper.m
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper

using namespace std;
using namespace cv;

+(UIImage *) makeGrayFromImage:(UIImage *)image {
    Mat imageMat;
    UIImageToMat(image, imageMat);
    
    if (imageMat.channels() == 1) {
        return image;
    }

    Mat grayMat;
    cvtColor(imageMat, grayMat, COLOR_BGR2GRAY);
    
    return MatToUIImage(grayMat);
}

+(UIImage *) stitchTwoImages: (NSMutableArray *) images {
    if (images.count < 2) {
        NSLog(@"imageArray is empty");
    }
    
    vector<Mat> matArray;
    
}

@end
