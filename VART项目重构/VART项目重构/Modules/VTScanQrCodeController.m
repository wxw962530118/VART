//
//  VTScanQrCodeController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/17.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTScanQrCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface VTScanQrCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

/*自定义导航栏*/
@property (nonatomic, strong) UIView *navigationBar;
/*导航栏上的文字*/
@property (nonatomic, strong) UILabel *titleNavLabel;
/**导航栏右侧闪光灯按钮*/
@property (nonatomic, strong) UIButton * titleNavRightBtn;
/*扫描的中间的细线*/
@property (nonatomic,strong) UIImageView * centerLine;
/*扫描背景图片*/
@property(nonatomic)UIImageView * bgImageView;
/*是否打开闪光灯*/
@property(nonatomic)BOOL isLight;
/*AVCaptureSession是AVFoundation的核心类,用于捕捉视频和音频,协调视频和音频的输入和输出流*/
@property(nonatomic)AVCaptureSession *session;

@property(nonatomic)AVCaptureDevice *device;

@property(nonatomic,strong)UILabel *titleLabel;

@property (nonatomic, copy) ScanResult  scanResult;

@end

@implementation VTScanQrCodeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self addCustomNavigationBar];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)addCustomNavigationBar{
    if (_navigationBar == nil) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (64))];
        _navigationBar.backgroundColor = SCColor(0, 0, 0);
        [self.view addSubview:_navigationBar];
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, (32), (50), (21));
        [backBtn setImage:[UIImage imageNamed:@"backWhite"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBar addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_navigationBar.mas_left).offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(21);
            make.centerY.equalTo(_navigationBar.mas_centerY);
        }];
        _titleNavLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (19))];
        _titleNavLabel.textAlignment = NSTextAlignmentCenter;
        _titleNavLabel.text = @"扫一扫";
        _titleNavLabel.font = [UIFont systemFontOfSize:19];
        _titleNavLabel.textColor = SCColorWhiteGround;
        [_navigationBar addSubview:_titleNavLabel];
        [_titleNavLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_navigationBar.mas_centerX);
            make.centerY.equalTo(_navigationBar.mas_centerY);
        }];
        
        
        _titleNavRightBtn = [[UIButton alloc]init];
        _titleNavRightBtn.backgroundColor = [UIColor clearColor];
        [_titleNavRightBtn addTarget:self action:@selector(flashLightClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleNavRightBtn setImage:[UIImage imageNamed:@"Light_Btn"] forState:UIControlStateNormal];
        [_titleNavRightBtn setTitle:@"开灯" forState:UIControlStateNormal];
        //self.readerView.torchMode = 0;
        _titleNavRightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _titleNavRightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _titleNavRightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_navigationBar addSubview:_titleNavRightBtn];
        [_titleNavRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_navigationBar.mas_right).offset(-20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(46);
            make.centerY.equalTo(_navigationBar.mas_centerY);
        }];

    }
}

-(void)back{
    [super back];
}

-(id)initWithBlock:(void(^)(NSString *result,BOOL isSucceed))result{
    if (self=[super init]) {
        self.scanResult = result;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"扫描二维码";
    self.isScanning=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self checkCamera];
}

- (void)checkCamera{
    //相机界面的定制在self.view上加载即可
    BOOL Custom= [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];//判断摄像头是否能用
    if (Custom) {
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusDenied){
            [self createBgImageView];
            [self showAlert];
        }else{
            [self initReadView];
            [self createView];
        }
    }else{
        [self createBgImageView];
        [self showAlert];
    }
    
}
- (void)showAlert{
    VTAlertView(@"未获得授权使用摄像头", @"请在iOS“设置”－“隐私”－“相机”中打开", @"稍后再说", @"去开启", ^(NSUInteger index) {
        if (index == 1) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    });
}

- (void)createBgImageView{
    [self.view addSubview:self.bgImageView];
}


-(UIImageView  *)bgImageView{
    if (_bgImageView == nil) {
        UIImage * image = [UIImage imageNamed:@"qrcode_scan_bg_blue"];
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight)];
        _bgImageView.center = CGPointMake(ScreenWidth/2.0 , ScreenHeight/2.0);
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
        _bgImageView.image = image;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        [self.view addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"将要扫描的二维码放置在扫描框内";
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).offset(161);
            make.height.mas_equalTo(14);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)centerLine{
    if (_centerLine == nil) {
        _centerLine = [[UIImageView alloc] init];
        _centerLine.bounds = CGRectMake(0, 0, (213), (8));
        _centerLine.center = CGPointMake(ScreenWidth/2.0,(ScreenHeight+(15))/2);
        _centerLine.image = [UIImage imageNamed:@"qrcode_scan_light_blue"];
    }
    return _centerLine;
}

-(void)createView{
    //中间的扫码区域
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.centerLine];
    [self animation1];
}

-(void)animation1{
    [UIView animateWithDuration:1.5 animations:^{
        if (self.isScanning) {
            self.centerLine.center = CGPointMake(ScreenWidth/2, (220));
        }
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            if (self.isScanning) {
                self.centerLine.center = CGPointMake(ScreenWidth/2.0, (128) + ScreenHeight/2);
            }
        }completion:^(BOOL finished) {
            if (self.isScanning) {
                [self animation1];
            }
        }];
    }];
    
}
- (void)initReadView{
    //获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat scanWidth = (242);
    //设置扫描范围（每一个值去0-1，以屏幕右上角为坐标原点）
    CGRect scanCrop = CGRectMake((1-scanWidth/ScreenHeight)/2.0,(1-scanWidth/ScreenWidth)/2.0 , scanWidth/ScreenHeight , scanWidth/ScreenWidth);
    [output setRectOfInterest:scanCrop];
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        AVCaptureMetadataOutput * outPut = weakSelf.session.outputs.firstObject;
        outPut.rectOfInterest = scanCrop;
    }];
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    //添加回话输入
    [_session addInput:input];
    //添加回话输出
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)-----设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
    //实例化预览图层传递_session是为了告诉图层将来显示什么内容
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    //将图层插入到当前视图
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}

#pragma mark --- 扫描结果输出
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects firstObject];
    if (metadataObject.stringValue.length!=0) {
        [self.view.layer removeAllAnimations];
        if (self.scanResult) {
            [self back];
            self.scanResult(metadataObject.stringValue,YES);
        }
        self.isScanning = NO;
        [_session stopRunning];
    }else{
        [self animation1];
        self.isScanning = YES;
        [_session startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (self.isLight) {
        [_device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device setFlashMode:AVCaptureFlashModeOff];
        [_device unlockForConfiguration];
    }
    self.isScanning = NO;
    [_session stopRunning];
    [super viewWillDisappear:animated];
}


#pragma mark --- 闪光灯相关事件
- (void)flashLightClick:(UIButton *)sender{
    self.isLight = !self.isLight;
    [_device lockForConfiguration:nil];
    if (self.isLight) {
       // _device.focusMode = AVCaptureFocusModeAutoFocus;
        [_device setTorchMode:AVCaptureTorchModeOn];
        [_device setFlashMode:AVCaptureFlashModeOn];
    }else{
        //_device.focusMode = AVCaptureFocusModeAutoFocus;
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device setFlashMode:AVCaptureFlashModeOff];
    }
    [_device unlockForConfiguration];
    [self.titleNavRightBtn setTitle:self.isLight ? @"关灯":@"开灯" forState:UIControlStateNormal];
}

@end
