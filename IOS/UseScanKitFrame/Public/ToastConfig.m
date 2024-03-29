//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import "ToastConfig.h"

static CGFloat toast_padding = 10;
static CGFloat toast_tipImageWidth = 0;
static CGFloat toast_cornerRadius = 7;
static CGFloat toast_fontSize = 15;
static CGFloat toast_imageCornerRadius = 0;

@implementation ToastConfig


static id _instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetConfig];
    }
    return self;
}

- (void)resetConfig {
    _showMask = NO;
    _maskColor = [UIColor clearColor];
    _iconColor = [UIColor whiteColor];
    _textColor = [UIColor whiteColor];
    _backColor = [UIColor colorWithWhite:0 alpha:0.8];
    _padding = toast_padding;
    _fontSize = toast_fontSize;
    _cornerRadius = toast_cornerRadius;
    _imageCornerRadius = toast_imageCornerRadius;
    _minWidth = kToastScreenWidth / 3;
    _tipImageSize = CGSizeMake(toast_tipImageWidth, toast_tipImageWidth);
}

@end
