//
//  OpenCVWrapper.h
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+(UIImage *) makeGrayFromImage:(UIImage *)image;
+(UIImage *) stitchTwoImages: (UIImage *) leftImage rightImage:(UIImage *) rightImage;

@end

NS_ASSUME_NONNULL_END
