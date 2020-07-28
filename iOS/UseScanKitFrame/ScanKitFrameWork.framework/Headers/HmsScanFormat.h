//
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, HMSScanFormatTypeCode) {
    AZTEC         = 1 << 0,
    CODABAR       = 1 << 1,
    CODE_39       = 1 << 2,
    CODE_93       = 1 << 3,
    CODE_128      = 1 << 4,
    DATA_MATRIX   = 1 << 5,
    EAN_8         = 1 << 6,
    EAN_13        = 1 << 7,
    ITF           = 1 << 8,
    PDF_417       = 1 << 9,
    QR_CODE       = 1 << 10,
    UPC_A         = 1 << 11,
    UPC_E         = 1 << 12,
    ALL           = (1<<13)-1
};

@interface HmsScanOptions : NSObject

@property (nonatomic, assign) unsigned int scanFormatType;
@property (nonatomic, assign) BOOL photoMode;

- (instancetype)initWithScanFormatType:(unsigned int)type Photo:(BOOL)photo;

@end
