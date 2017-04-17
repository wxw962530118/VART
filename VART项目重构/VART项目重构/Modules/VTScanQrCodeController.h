//
//  VTScanQrCodeController.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/17.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTBaseViewController.h"

typedef void(^ScanResult)(NSString*result,BOOL isSucceed);

@interface VTScanQrCodeController : VTBaseViewController

@property(nonatomic,assign)BOOL isScanning;

-(id)initWithBlock:(ScanResult)result;

@end
