//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kToastConfig ([ToastConfig sharedInstance])
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define kToastMultilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define kToastMultilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize] : CGSizeZero;
#endif
#define kToastScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kToastScreenHeight ([UIScreen mainScreen].bounds.size.height)

static inline BOOL Toast_isIphoneX() {
    BOOL result = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return result;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            result = YES;
        }
    }
    return result;
}

@interface ToastConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)sharedInstance;
@property (nonatomic, assign) BOOL showMask;
@property (nonatomic, assign) BOOL maskCoverNav;
@property (nonatomic, assign) BOOL alwaysResetConfig;
@property (nonatomic, strong) UIColor *maskColor;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIColor *iconColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGSize tipImageSize;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat imageCornerRadius;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat minWidth;

- (void)resetConfig;


@end

