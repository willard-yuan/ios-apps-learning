//
//  opencvWrapper.m
//  hello_camera
//
//  Created by willard on 16/9/4.
//  Copyright © 2016年 wilard. All rights reserved.
//

#import "openCVWrapper.h"
#import <opencv2/opencv.hpp>

@implementation openCVWrapper

+(NSString *) getOpenCVVersion
{
    return [NSString stringWithFormat:@"OpenCV Version %s",CV_VERSION];
}

@end
