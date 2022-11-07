//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import "Toast.h"
#import "ToastView.h"
#import "ToastConfig.h"

@interface Toast()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ToastView *toastView;
@property (nonatomic, strong) NSTimer *toastTimer;
@property (nonatomic, copy) dispatch_block_t finishHandler;
@end

@implementation Toast

static id _instance;
+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - show toast
+ (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [[self sharedInstance] showToastWithType:ToastTypeSuccess Message:message originY:0 image:nil duration:duration finishHandler:handler];
}

+ (void)showSuccessWithMessage:(NSString *)message originY:(CGFloat)originY duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [[self sharedInstance] showToastWithType:ToastTypeSuccess Message:message originY:originY image:nil duration:duration finishHandler:handler];
}

+(void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [[self sharedInstance] showToastWithType:ToastTypeError Message:message originY:0 image:nil duration:duration finishHandler:handler];
}

+ (void)showErrorWithMessage:(NSString *)message originY:(CGFloat)originY duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [[self sharedInstance] showToastWithType:ToastTypeError Message:message originY:originY image:nil duration:duration finishHandler:handler];
}

+ (void)showMessage:(NSString *)message originY:(CGFloat)originY duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [[self sharedInstance] showToastWithType:ToastTypeWords Message:message originY:originY image:nil duration:duration finishHandler:handler];
}

+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [[self sharedInstance] showToastWithType:ToastTypeWords Message:message originY:0 image:nil duration:duration finishHandler:handler];
}

+ (void)hide {
    [[self sharedInstance] removeToast];
}

#pragma mark - configuration

+ (void)setShowMask:(BOOL)showMask {
    kToastConfig.showMask = showMask;
}

+ (void)setMaskColor:(UIColor *)maskColor {
    kToastConfig.maskColor = maskColor;
}

+ (void)setMaskCoverNav:(BOOL)maskCoverNav {
    kToastConfig.maskCoverNav = maskCoverNav;
}

+ (void)setPadding:(CGFloat)padding {
    kToastConfig.padding = padding;
}

+ (void)setTipImageSize:(CGSize)tipImageSize {
    kToastConfig.tipImageSize = tipImageSize;
}

+ (void)setCornerRadius:(CGFloat)cornerRadius {
    kToastConfig.cornerRadius = cornerRadius;
}

+ (void)setImageCornerRadius:(CGFloat)cornerRadius {
    kToastConfig.imageCornerRadius = cornerRadius;
}

+ (void)setBackColor:(UIColor *)backColor {
    kToastConfig.backColor = backColor;
}

+ (void)setIconColor:(UIColor *)iconColor {
    kToastConfig.iconColor = iconColor;
}

+ (void)setTextColor:(UIColor *)textColor {
    kToastConfig.textColor = textColor;
}

+ (void)setFontSize:(CGFloat)fontSize {
    kToastConfig.fontSize = fontSize;
}

+ (void)resetConfig {
    [kToastConfig resetConfig];
}

#pragma mark - private

- (void)showToastWithType:(ToastType)type Message:(NSString *)message originY:(CGFloat)originY image:(UIImage *)image duration:(NSTimeInterval)duration finishHandler:(dispatch_block_t)handler {
    [self guard];
    self.finishHandler = handler;
    self.toastView = [ToastView toastWithMessage:message type:type originY:originY tipImage:image];
    self.toastView.alpha = 0;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (kToastConfig.showMask) {
        self.maskView = [self maskViewWithColor:kToastConfig.maskColor coverNav:kToastConfig.maskCoverNav];
        self.maskView.alpha = 0;
        [keyWindow addSubview:self.maskView];
        [keyWindow addSubview:self.toastView];
    } else {
        [keyWindow addSubview:self.toastView];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 1;
        self.toastView.alpha = 1;
    }];
    [self duration:duration];
}

- (void)guard {
    if (self.toastView.superview != nil || self.toastView) {
        [self removeToast];
    }
}

- (void)duration:(NSTimeInterval)duration {
    self.toastTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(finishDismiss) userInfo:nil repeats:NO];
}

- (void)finishDismiss {
    [UIView animateWithDuration:1 animations:^{
        
    }];
    [self removeToast];
    if (self.finishHandler) { self.finishHandler(); }
}

- (void)removeToast {
    [self.toastTimer invalidate];
    self.toastTimer = nil;
    [self.toastView removeFromSuperview];
    [self.maskView removeFromSuperview];
    self.toastView = nil;
    self.maskView = nil;
}

- (UIView *)maskViewWithColor:(UIColor *)color coverNav:(BOOL)coverNav {
    UIView *maskView = [[UIView alloc] init];
    CGFloat topHeight = Toast_isIphoneX() ? 88 : 64;
    CGFloat y = coverNav ? 0 : topHeight;
    maskView.frame = CGRectMake(0, y, kToastScreenWidth, kToastScreenHeight - y);
    maskView.backgroundColor = color;
    return maskView;
}

@end
