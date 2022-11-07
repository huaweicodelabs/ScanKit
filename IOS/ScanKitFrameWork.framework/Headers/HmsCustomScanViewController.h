//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HmsScanFormat.h"

@class HmsCustomScanViewController;
@protocol CustomizedScanDelegate <NSObject>
@optional
/*CustomizedScan Delegate
 Data returned by code scanning
*/
- (void)customizedScanDelegateForResult:(NSDictionary *)resultDic;

@end

@interface HmsCustomScanViewController : UIViewController

@property (nonatomic, weak) id <CustomizedScanDelegate> customizedScanDelegate;

/*
 set scan format
*/
-(instancetype)initCustomizedScanWithFormatType:(HmsScanOptions *)scanOptions;

/*
 hide back button bool, (ture: show; false: hide) defaults to show
 */
@property (nonatomic) BOOL backButtonHidden;

/*
 Identification area
 */
@property (nonatomic) CGRect cutArea;

/*
 Bool, (ture:continue scanning; false:end scanning and viewController can be back), defaults to end scanning
 */
@property (nonatomic) BOOL continuouslyScan;

/*
 pause continuous scan
 */
-(void)pauseContinuouslyScan;

/*
 resume continuous scan
 */
-(void)resumeContinuouslyScan;

/*
 back action
 */
-(void)backAction;

@end
