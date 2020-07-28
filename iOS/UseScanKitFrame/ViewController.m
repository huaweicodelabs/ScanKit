//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
// 

#import "ViewController.h"
#import <ScanKitFrameWork/ScanKitFrameWork.h>
#import "Define.h"
#import "UIView+Toast.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<DefaultScanDelegate, CustomizedScanDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>{
    UILabel *versionLabel;//version
}
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"ScanKit";
    [self.navigationController.navigationBar setBarTintColor:ColorRGB(55, 199, 190)];
    
    versionLabel = [[UILabel alloc] init];
    versionLabel.frame = CGRectMake(30, SCREEN_HEIGHT-80, SCREEN_WIDTH-60, 30);
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = Font16;
    [self.view addSubview:versionLabel];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    versionLabel.text = [NSString stringWithFormat:@"version：%@", version];
}

//Default View Mode
-(IBAction)buttonAction:(id)sender{
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:FALSE];
    HmsDefaultScanViewController *hmsDefaultScanViewController = [[HmsDefaultScanViewController alloc] initDefaultScanWithFormatType:options];
    hmsDefaultScanViewController.defaultScanDelegate = self;
    
    [self.view addSubview:hmsDefaultScanViewController.view];
    [self addChildViewController:hmsDefaultScanViewController];
    [self didMoveToParentViewController:hmsDefaultScanViewController];
    self.navigationController.navigationBarHidden = YES;
}

//DefaultScan Delegate
- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic{
    [self toastResult:resultDic];
}

- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image{
    NSDictionary *dic = [HmsBitMap bitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    [self toastResult:dic];
}

-(void)toastResult:(NSDictionary *)dic{
    [self.navigationController.view hideToastActivity];
    if (dic == nil){
        [self.view makeToast:@"Scanning code not recognized" duration:1.0 position:@"CSToastPositionCenter" boolToast:YES];
        return;
    }
    
    NSString *string = [NSString stringWithFormat:@"%@", [dic objectForKey:@"text"]];
    if ([string length] == 0){
        [self.view makeToast:@"Scanning code not recognized" duration:1 position:@"CSToastPositionCenter" boolToast:YES];
        return;
    }
    
    NSString *toastString = [NSString stringWithFormat:@"CodeFormat=%@; ResultType=%@; Result=%@", [dic objectForKey:@"formatValue"], [dic objectForKey:@"sceneType"], [dic objectForKey:@"text"]];
    [self.view makeToast:toastString duration:2.0 position:@"CSToastPositionCenter" boolToast:YES];
}

//Customized View Mode
-(IBAction)buttonCustomizedAction:(id)sender{
    HmsCustomScanViewController *hmsCustomScanViewController = [[HmsCustomScanViewController alloc] init];
    hmsCustomScanViewController.customizedScanDelegate = self;
    hmsCustomScanViewController.backButtonHiden = false;
    //hmsCustomScanViewController.cutArea = CGRectMake(50, 50, 300, 300);
    [self.view addSubview:hmsCustomScanViewController.view];
    [self addChildViewController:hmsCustomScanViewController];
    [self didMoveToParentViewController:hmsCustomScanViewController];
    self.navigationController.navigationBarHidden = YES;
}

//CustomizedScan Delegate
- (void)customizedScanDelegateForResult:(NSDictionary *)resultDic{
    [self toastResult:resultDic];
}

//BitMap View Mode
-(IBAction)bitMapAction:(id)sender{
    [self imagePickersourceType:@"Album"];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickersourceType:(NSString *)type{
    if ([type isEqualToString:@"Album"]){
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:^{}];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSDictionary *dic = [HmsBitMap bitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    
    [self toastResult:dic];
    [picker dismissViewControllerAnimated:YES completion:^{ }];
}

@end
