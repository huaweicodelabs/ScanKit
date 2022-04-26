//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//


#define WelcomeStudents_Define_h

#ifdef __OBJC__


#define ColorRGBA(R,G,B,A)           [UIColor colorWithRed:R / 255.0 green:G / 255.0  blue:B / 255.0  alpha:A]
#define ColorRGB(R,G,B)              [UIColor colorWithRed:R / 255.0 green:G / 255.0  blue:B / 255.0  alpha:1.0]


#define Font12          [UIFont fontWithName:@"Arial" size:12]
#define Font14          [UIFont fontWithName:@"Arial" size:14]
#define Font16          [UIFont fontWithName:@"Arial" size:16]
#define Font(m)         [UIFont fontWithName:@"Arial" size:m]

#define iosVersion() [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define kNaviTitleHeight ((iosVersion()>=7.0) ? 65 : 45)


typedef void(^failureBlock)(NSError *error);

#endif
