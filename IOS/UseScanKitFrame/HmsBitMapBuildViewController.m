//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import "HmsBitMapBuildViewController.h"
#import "UIView+Toast.h"
#import "Define.h"
#import <ScanKitFrameWork/ScanKitFrameWork.h>

@interface HmsBitMapBuildViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>{
    UITextField *contentTextField;
    UITextField *hTextField;
    UITextField *wTextField;
    UIButton *seleteTypeButton;
    UIButton *makeSureButton;
    UIImageView *imgView;
    
    UIView *blurView;
    UIView *pickerBgView;
    UIPickerView *seletePicker;
    NSArray *codeTypeList;
    NSString *seleteCodeTypeString;
}

@end

@implementation HmsBitMapBuildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Generative Code";
    self.view.backgroundColor = ColorRGB(220, 220, 220);
    [self _creatBackButton];
    codeTypeList = [NSArray arrayWithObjects:@"AztecCodeGenerator",
                    @"PDF417BarcodeGenerator",
                    @"QRCodeGenerator",
                    @"DataMatrixCodeGenerator",
                    @"Code128BarcodeGenerator",
                    @"Code93BarcodeGenerator",
                    @"Code39BarcodeGenerator",
                    @"UPCABarcodeGenerator",
                    @"UPCEBarcodeGenerator",
                    @"CodaBarcodeGenerator",
                    @"ITFBarcodeGenerator",
                    @"EAN8BarcodeGenerator",
                    @"EAN13BarcodeGenerator",
                    nil];
    blurView.hidden = YES;
    pickerBgView.hidden = YES;
    [self initUIView];
}

-(void)initUIView{
    contentTextField = [[UITextField alloc] init];
    contentTextField.frame = CGRectMake(30, kNaviTitleHeight+30, SCREEN_WIDTH-60, 45);
    contentTextField.backgroundColor = ColorRGB(179, 143, 0);
    contentTextField.placeholder = @"  Content";
    contentTextField.font = Font16;
    [self.view addSubview:contentTextField];
    
    hTextField = [[UITextField alloc] init];
    hTextField.frame = CGRectMake(30+(SCREEN_WIDTH-70)/2+10, contentTextField.frame.origin.y+contentTextField.frame.size.height+20, (SCREEN_WIDTH-70)/2, 45);
    hTextField.keyboardType = UIKeyboardTypePhonePad;
    hTextField.backgroundColor = ColorRGB(179, 143, 0);
    hTextField.placeholder = @"  Height";
    hTextField.font = Font16;
    [self.view addSubview:hTextField];
    
    wTextField = [[UITextField alloc] init];
    wTextField.frame = CGRectMake(30, contentTextField.frame.origin.y+contentTextField.frame.size.height+20, (SCREEN_WIDTH-70)/2, 45);
    wTextField.keyboardType = UIKeyboardTypePhonePad;
    wTextField.backgroundColor = ColorRGB(179, 143, 0);
    wTextField.placeholder = @"  Width";
    wTextField.font = Font16;
    [self.view addSubview:wTextField];
    
    seleteTypeButton = [UIButton buttonWithType:0];
    seleteTypeButton.frame = CGRectMake(30, wTextField.frame.origin.y+wTextField.frame.size.height+20, SCREEN_WIDTH-60, 45);
    seleteTypeButton.backgroundColor = [UIColor blueColor];
    [seleteTypeButton setTitle:[codeTypeList objectAtIndex:0] forState:UIControlStateNormal];
    seleteCodeTypeString = [codeTypeList objectAtIndex:0];
    seleteTypeButton.titleLabel.font = Font16;
    seleteTypeButton.titleLabel.textColor = ColorRGB(0, 86, 179);
    [seleteTypeButton addTarget:self action:@selector(seleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seleteTypeButton];
    
    makeSureButton = [UIButton buttonWithType:0];
    makeSureButton.frame = CGRectMake(30, seleteTypeButton.frame.origin.y+seleteTypeButton.frame.size.height+20, SCREEN_WIDTH-60, 45);
    makeSureButton.backgroundColor = [UIColor blueColor];
    [makeSureButton setTitle:@"Confirm" forState:UIControlStateNormal];
    makeSureButton.titleLabel.font = Font16;
    makeSureButton.titleLabel.textColor = ColorRGB(0, 86, 179);
    [makeSureButton addTarget:self action:@selector(qdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeSureButton];
    [self initPickerView];
}

-(void)initPickerView{
    blurView = [[UIView alloc] init];
    blurView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    blurView.backgroundColor = ColorRGBA(0.0, 0.0, 0.0, 0.6);
    [self.navigationController.view addSubview:blurView];
    blurView.hidden = YES;
    
    pickerBgView = [[UIView alloc] init];
    pickerBgView.frame = CGRectMake(0, SCREEN_HEIGHT-240, SCREEN_WIDTH, 240);
    pickerBgView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:pickerBgView];
    UIButton *cancelButton = [UIButton buttonWithType:0];
    cancelButton.frame = CGRectMake(0, 0, 70, 40);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:ColorRGB(0, 111, 222) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerBgView addSubview:cancelButton];
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 39, SCREEN_WIDTH, 1);
    lineView.backgroundColor = ColorRGB(230, 230, 230);
    [pickerBgView addSubview:lineView];
    UIButton *sureButton = [UIButton buttonWithType:0];
    sureButton.frame = CGRectMake(SCREEN_WIDTH-70, 0, 70, 40);
    [sureButton setTitle:@"OK" forState:UIControlStateNormal];
    [sureButton setTitleColor:ColorRGB(0, 111, 222) forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerBgView addSubview:sureButton];

    seletePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
    seletePicker.backgroundColor = [UIColor whiteColor];
    seletePicker.delegate = self;
    seletePicker.dataSource = self;
    [pickerBgView addSubview:seletePicker];
    
    pickerBgView.hidden = YES;
}

-(void)cancelButtonAction:(id)sender{
    blurView.hidden = YES;
    pickerBgView.hidden = YES;
}

-(void)sureButtonAction:(id)sender{
    blurView.hidden = YES;
    pickerBgView.hidden = YES;
    if (seleteCodeTypeString.length == 0) {
        seleteCodeTypeString = [codeTypeList objectAtIndex:0];
    }
    [seleteTypeButton setTitle:seleteCodeTypeString forState:UIControlStateNormal];
}

-(void)seleteButtonAction:(id)sender{
    [contentTextField resignFirstResponder];
    [hTextField resignFirstResponder];
    [wTextField resignFirstResponder];
    blurView.hidden = NO;
    pickerBgView.hidden = NO;
}
-(void)qdButtonAction:(id)sender{
    [contentTextField resignFirstResponder];
    [hTextField resignFirstResponder];
    [wTextField resignFirstResponder];
    if ([self hasBlankSpace:contentTextField.text] == YES) {
        [self.view makeToast:@"Please enter the content to be transcoded" duration:2.0 position:@"CSToastPositionCenter"];
        return;
    }
    if (contentTextField.text.length > 2300) {
        [self.view makeToast:@"Too many entries to transcode" duration:2.0 position:@"CSToastPositionCenter"];
        return;
    }
    if ([self hasBlankSpace:wTextField.text] == YES) {
        //Default width if no width is entered
        wTextField.text = [NSString stringWithFormat:@"%d", (int)(SCREEN_WIDTH-60)];
    }
    if ([self hasBlankSpace:hTextField.text] == YES) {
        //Default width if no width is entered
        if ([seleteCodeTypeString isEqualToString:@"AztecCodeGenerator"] || [seleteCodeTypeString isEqualToString:@"QRCodeGenerator"] || [seleteCodeTypeString isEqualToString:@"DataMatrixCodeGenerator"]) {//Need to generate square code graph
            hTextField.text = [NSString stringWithFormat:@"%d", (int)(SCREEN_WIDTH-60)];
        }else{
            hTextField.text = [NSString stringWithFormat:@"%d", (int)(SCREEN_WIDTH-60)/2];
        }
    }
    if ([self deptNumInputShouldNumber:wTextField.text] == NO) {
        [self.view makeToast:@"please enter a number" duration:2.0 position:@"CSToastPositionCenter"];
        return;
    }
    if ([self hasBlankSpace:seleteCodeTypeString] == YES) {
        [self.view makeToast:@"Please select the type to transcode" duration:2.0 position:@"CSToastPositionCenter"];
        return;
    }
    if (imgView != nil) {
        [imgView removeFromSuperview];
    }
    float w = [wTextField.text floatValue];
    float h = [hTextField.text floatValue];
    if (w<35) {
        [self.view makeToast:@"Code chart width is too small" duration:2.0 position:@"CSToastPositionCenter"];
        return;
    }
    if (w>SCREEN_WIDTH-60) {
        w = SCREEN_WIDTH-60;
        wTextField.text = [NSString stringWithFormat:@"%d", (int)w];
    }
    if ([seleteCodeTypeString isEqualToString:@"AztecCodeGenerator"] || [seleteCodeTypeString isEqualToString:@"QRCodeGenerator"] || [seleteCodeTypeString isEqualToString:@"DataMatrixCodeGenerator"]) {//Need to generate square code graph
        h = w;
        hTextField.text = [NSString stringWithFormat:@"%d", (int)w];
    }
    float upHeight = makeSureButton.frame.origin.y+makeSureButton.frame.size.height;
    if (h>SCREEN_HEIGHT-upHeight) {
        h = SCREEN_HEIGHT-upHeight-50;
        hTextField.text = [NSString stringWithFormat:@"%d", (int)h];
    }
    UIImage *image = [self buildBitmapForType:seleteCodeTypeString content:contentTextField.text width:w height:h];
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, upHeight+(SCREEN_HEIGHT-upHeight)/2-h/2, w, h)];
    imgView.image = image;
    [self.view addSubview:imgView];
}

-(UIImage *)buildBitmapForType:(NSString *)type content:(NSString *)content width:(float)width height:(float)height{
    HMSScanFormatTypeCode format;
    if ([type isEqualToString:@"AztecCodeGenerator"]){
        format = AZTEC;
    }
    else if ([type isEqualToString:@"PDF417BarcodeGenerator"]){
        format = PDF_417;
    }
    else if ([type isEqualToString:@"QRCodeGenerator"]){
        format = QR_CODE;
    }
    else if ([type isEqualToString:@"DataMatrixCodeGenerator"]){
        format = DATA_MATRIX;
    }
    else if ([type isEqualToString:@"Code128BarcodeGenerator"]){
        format = CODE_128;
    }
    else if ([type isEqualToString:@"Code39BarcodeGenerator"]){
        format = CODE_39;
    }
    else if ([type isEqualToString:@"Code93BarcodeGenerator"]){
        format = CODE_93;
    }
    else if ([type isEqualToString:@"UPCABarcodeGenerator"]){
        format = UPC_A;
    }
    else if ([type isEqualToString:@"UPCEBarcodeGenerator"]){
        format = UPC_E;
    }
    else if ([type isEqualToString:@"CodaBarcodeGenerator"]){
        format = CODABAR;
    }
    else if ([type isEqualToString:@"ITFBarcodeGenerator"]){
        format = ITF;
    }
    else if ([type isEqualToString:@"EAN8BarcodeGenerator"]){
        format = EAN_8;
    }
    else {
        format = EAN_13;
    }
    
    CGSize size = CGSizeMake(width, height);
    NSError *err;
    UIImage *image = [HmsMultiFormatWriter createCodeWithString:content size:size CodeFomart:format error:&err];
    if (err != nil) {
        //NSInteger code = err.code;
        NSDictionary *userInfo = err.userInfo;
        [self.view makeToast:[userInfo objectForKey:@"NSLocalizedDescription"] duration:2.0 position:@"CSToastPositionCenter"];
        return nil;
    }
    return image;
}
#pragma mark --- DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return codeTypeList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [codeTypeList objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    seleteCodeTypeString = [codeTypeList objectAtIndex:row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    ((UILabel *)[seletePicker.subviews objectAtIndex:1]).backgroundColor =  ColorRGB(235, 235, 235);
    ((UILabel *)[seletePicker.subviews objectAtIndex:2]).backgroundColor =  ColorRGB(235, 235, 235);
    return pickerLabel;
}

-(BOOL)hasBlankSpace:(NSString *)str{
    NSRange range = [str rangeOfString:@" "];
    if(range.location!=NSNotFound) {//有空格
        return NO;
    }else{//没有空格
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0){
            return YES;
        }else{
            return NO;
        }
    }
}
- (BOOL)deptNumInputShouldNumber:(NSString *)str{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)_creatBackButton
{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(backAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"personal_back.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"personal_back.png"] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=btnItem;
}

-(void)backAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
