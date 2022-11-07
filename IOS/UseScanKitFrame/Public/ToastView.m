//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import "ToastView.h"
#import "ToastConfig.h"

@interface ToastView()
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) CGFloat padding;
@end

@implementation ToastView

+ (instancetype)toastWithMessage:(NSString *)message type:(ToastType)type originY:(CGFloat)originY tipImage:(UIImage *)image {
    ToastView *toastView = [[ToastView alloc] init];
    toastView.padding = message ? kToastConfig.padding : 0;
    [toastView setCommonWithMessage:message type:type];
    [toastView setFrameWithMessage:message type:type originY:originY];
    return toastView;
}

- (void)setCommonWithMessage:(NSString *)message type:(ToastType)type {
    self.backgroundColor = kToastConfig.backColor;
    self.layer.cornerRadius = kToastConfig.cornerRadius;
    self.layer.masksToBounds = YES;
    self.messageLabel.text = message;
    [self.messageLabel setTextColor:kToastConfig.textColor];
    self.messageLabel.font = [UIFont systemFontOfSize:kToastConfig.fontSize];
}

- (void)setFrameWithMessage:(NSString *)message type:(ToastType)type originY:(CGFloat)originY {
    CGSize toastSize = [self getToastSizeWithMessage:message type:type];
    CGFloat space = Toast_isIphoneX() ? 34 : 0;
    CGFloat y = (originY > 0) ? originY : ((kToastScreenHeight - toastSize.height) / 2);
    if (Toast_isIphoneX() && y < space) { y = space; }
    y = ((y + toastSize.height) > (kToastScreenHeight - space)) ? (kToastScreenHeight - toastSize.height - space) : y;
    CGFloat toastWidth = kToastConfig.minWidth > toastSize.width ? kToastConfig.minWidth : toastSize.width;
    self.frame = CGRectMake((kToastScreenWidth - toastWidth) / 2, y, toastWidth, toastSize.height);
    [self addConstraintWithType:type message:message];
}

- (CGSize)getToastSizeWithMessage:(NSString *)message type:(ToastType)type {
    CGFloat normalPadding = 2 * self.padding;
    if (type == ToastTypeImage && !message) {
        return CGSizeMake(kToastConfig.tipImageSize.width + normalPadding, kToastConfig.tipImageSize.height + normalPadding);
    }
    UIFont *font = [UIFont systemFontOfSize:kToastConfig.fontSize];
    CGSize textSize = kToastMultilineTextSize(message, font, CGSizeMake(0.7 * kToastScreenWidth, 0.7 * kToastScreenHeight));
    CGFloat labelWidth = textSize.width + 1;
    CGFloat labelHeight = textSize.height + 1;
    CGFloat heightPadding = (type == ToastTypeWords) ? (2 * self.padding) : (2.5 * self.padding);
    CGSize imageSize = (type == ToastTypeWords) ? CGSizeMake(0, 0) : kToastConfig.tipImageSize;
    CGFloat toastHeight = imageSize.height + heightPadding + labelHeight;
    CGFloat toastWidth = ((labelWidth > imageSize.width) || (type == ToastTypeWords)) ? labelWidth + (2 * self.padding) : imageSize.width + (2 * self.padding);
    return CGSizeMake(toastWidth, toastHeight);
}

- (void)addConstraintWithType:(ToastType)type message:(NSString *)message {
    [self addSubview:self.messageLabel];
    [self.messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    if (type == ToastTypeWords) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.padding]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.padding]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.padding]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.padding]];
    } else {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.padding]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.padding]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.padding]];
    }
}

#pragma mark - property
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _messageLabel;
}

@end
