//
//  OpenCVWrapper.m
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv2.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/Imgproc.h>
#import <opencv2/Core.h>
#import <opencv2/Features2d.h>

@implementation OpenCVWrapper

+(UIImage *) makeGrayFromImage:(UIImage *)image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    if (imageMat.channels() == 1) {
        return image;
    }

    cv::Mat grayMat;
    cvtColor(imageMat, grayMat, cv::COLOR_BGR2GRAY);
    
    return MatToUIImage(grayMat);
}

+(UIImage *) stitchTwoImages: (UIImage *) leftImage rightImage:(UIImage *) rightImage {
    cv::Mat leftImageMat, rightImageMat;
    
    UIImageToMat(leftImage, leftImageMat);
    UIImageToMat(rightImage, rightImageMat);
    
    // 1. convert to Gray
    cv::Mat leftGrayImageMat, rightGrayImageMat;
    
    if (leftImageMat.channels() == 1) {
        leftGrayImageMat = leftImageMat;
    } else {
        cvtColor(leftImageMat, leftGrayImageMat, cv::COLOR_BGR2GRAY);
    }
    
    if (rightGrayImageMat.channels() == 1) {
        rightGrayImageMat = rightImageMat;
    } else {
        cvtColor(rightImageMat, rightGrayImageMat, cv::COLOR_BGR2GRAY);
    }
    
    // 2. Detect the keypoints
    std::vector<cv::KeyPoint> leftKeyPoints, rightKeyPoints;
    cv::FeatureDetector Detector;
    
    Detector.detect(leftGrayImageMat, leftKeyPoints);
    Detector.detect(rightGrayImageMat, rightKeyPoints);
    
    // 3. calculate Descriptors
    cv::DescriptorExtractor Extractor;
    cv::Mat leftDescriptorsMat, rightDescriptorsMat;
    
    Extractor.compute(leftGrayImageMat, leftKeyPoints, leftDescriptorsMat);
    Extractor.compute(rightGrayImageMat, rightKeyPoints, rightDescriptorsMat);
    
    // 4. matching descriptor vectors using FLANN matcher
    // left image에서 키포인트들 중에서 right image에서 나타나는 키포인트 들중 가까운 것들을 찾는다
    // 그리고 descriptor들 사이의 매칭 결과를 matches에 저장
    cv::FlannBasedMatcher Matcher;
    std::vector<cv::DMatch> matches;
    
    Matcher.match(leftDescriptorsMat, rightDescriptorsMat, matches);
    
    // 두 매치 포인트에서 min max를 계산해서 가까운 자리에 있는 애들끼리 사용
    double minDist = 0, maxDist = 100;
    for (int i = 0; i < leftDescriptorsMat.rows; i++) {
        double dist = matches[i].distance;
        
        if (dist < minDist) {
            minDist = dist;
        }
        if (dist > maxDist) {
            maxDist = dist;
        }
    }
    
    NSLog(@"%f", minDist);
    NSLog(@"%f", maxDist);
    
    std::vector<cv::DMatch> goodMatches;
    for (int i = 0; i < leftDescriptorsMat.rows; i++) {
        if (matches[i].distance < 3 * minDist) {
            goodMatches.push_back(matches[i]);
        }
    }
    
    // 5. calculate homography
    std::vector<cv::Point2f> leftPoints, rightPoints;
    
    for (int i = 0; i < goodMatches.size(); i++) {
        leftPoints.push_back(leftKeyPoints[goodMatches[i].queryIdx].pt);
        rightPoints.push_back(rightKeyPoints[goodMatches[i].trainIdx].pt);
    }
    
    // Homography matrix
    cv::Mat homoMatrix = findHomography(leftPoints, rightPoints, cv::RANSAC);
    
    // 6. warp the images using homography
    cv::Mat resultMat;
    
    warpPerspective(rightImageMat, resultMat, homoMatrix, cv::Size(rightImageMat.cols * 2, rightImageMat.rows));
    
    cv::Mat panoramaMat;
    panoramaMat = resultMat.clone();
    
    cv::Mat tempMat(panoramaMat, cv::Rect(0, 0, leftImageMat.cols, leftImageMat.rows));
    leftImageMat.copyTo(tempMat);
    
    // cv::Mat panoramaMat;
    return MatToUIImage(panoramaMat);
}

@end
