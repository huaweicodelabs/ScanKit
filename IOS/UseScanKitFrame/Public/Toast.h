//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toast : NSObject

+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler;
+ (void)showMessage:(NSString *)message originY:(CGFloat)originY duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler;
+ (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler;
+ (void)showSuccessWithMessage:(NSString *)message originY:(CGFloat)originY duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler;
+ (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler;

+ (void)showErrorWithMessage:(NSString *)message originY:(CGFloat)originY duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler;
+ (void)hide;
+ (void)setShowMask:(BOOL)showMask;
+ (void)setMaskColor:(UIColor *)maskColor;
+ (void)setMaskCoverNav:(BOOL)maskCoverNav;
+ (void)setPadding:(CGFloat)padding;
+ (void)setTipImageSize:(CGSize)tipImageSize;
+ (void)setCornerRadius:(CGFloat)cornerRadius;
+ (void)setImageCornerRadius:(CGFloat)cornerRadius;
+ (void)setBackColor:(UIColor *)backColor;
+ (void)setIconColor:(UIColor *)iconColor;
+ (void)setTextColor:(UIColor *)textColor;
+ (void)setFontSize:(CGFloat)fontSize;
+ (void)resetConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

