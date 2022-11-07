//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HmsScanFormat.h"
#import <AVFoundation/AVFoundation.h>

@interface HmsBitMap : NSObject

/*
get result from the UIImage
*/
+(NSDictionary *)bitMapForImage:(UIImage *)image withOptions:(HmsScanOptions *)options;

/*
get multiple result from the UIImage
*/
+ (NSArray *)multiDecodeBitMapForImage:(UIImage *)image withOptions:(HmsScanOptions *)options;

/*
 get result from the sampleBuffer
*/
+(NSDictionary *)bitMapForSampleBuffer:(CMSampleBufferRef)sampleBuffer withOptions:(HmsScanOptions *)options;

/*
 get multiple result from the sampleBuffer
*/
+(NSArray *)multiDecodeBitMapForSampleBuffer:(CMSampleBufferRef)sampleBuffer withOptions:(HmsScanOptions *)options;

@end
