//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HmsScanFormat.h"

@interface HmsBitMap : NSObject

+(NSDictionary *)bitMapForImage:(UIImage *)image withOptions:(HmsScanOptions *)options;

@end
