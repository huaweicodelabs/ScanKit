//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HmsScanFormat.h"

@protocol DefaultScanDelegate <NSObject>
@optional
/*DefaultScan Delegate
  Data returned by code scanning
 */
- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic;

/*DefaultScan Delegate
  Data returned by album pictures
 */
- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image;

@end

@interface HmsDefaultScanViewController : UIViewController

@property (nonatomic, weak) id <DefaultScanDelegate> defaultScanDelegate;

/*
 set scan format
*/
-(instancetype)initDefaultScanWithFormatType:(HmsScanOptions *)scanOptions;

@end
