//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ToastType) {
    ToastTypeSuccess = 0,
    ToastTypeError,
    ToastTypeWords,
    ToastTypeImage,
};

@interface ToastView : UIView

+ (instancetype)toastWithMessage:(NSString *)message type:(ToastType)type originY:(CGFloat)originY tipImage:(UIImage *)image;

@end

