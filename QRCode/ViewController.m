//
//  ViewController.m
//  QRCode
//
//  Created by Johnson on 2017/6/12.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIAlertView+Tools.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AVCaptureSession *_captureSession;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 2.添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [_captureSession addInput:input];
    
    // 3.添加输出数据(示例对象-->类对象-->元类对象-->根元类对象)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:(id)self queue:dispatch_get_main_queue()];
    [_captureSession addOutput:output];
    
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    layer.frame = [[[UIApplication sharedApplication] delegate] window].bounds;
    [self.view.layer addSublayer:layer];
    
    // 5.开始扫描
    [_captureSession startRunning];
    
    
    UITapGestureRecognizer *tapGetture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTorch)];
    tapGetture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGetture];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Selector

- (void)openTorch
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    device.torchAvailable ? [device setTorchMode: device.torchActive ? AVCaptureTorchModeOff : AVCaptureTorchModeOn] : nil;
    [device unlockForConfiguration];
}

#pragma mark - Private Methods

- (NSString *)checkURL:(NSString *)string
{
    NSError *error;
    
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    
    NSArray *arrayOfAllMatches = [dataDetector matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    
    //有且仅有一条链接时返回，否则为空
    return arrayOfAllMatches.count != 1 ? nil : [[arrayOfAllMatches firstObject] URL].absoluteString;
    
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray <AVMetadataMachineReadableCodeObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection;
{
    [_captureSession stopRunning];
    
    NSMutableString *msg = [@"" mutableCopy];
    
    [metadataObjects enumerateObjectsUsingBlock:^(AVMetadataMachineReadableCodeObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [msg appendString:obj.stringValue];
    }];
    
    if ([msg isEqualToString:@""]) {
        [_captureSession startRunning];
        return;
    }
    
    NSString *url = [self checkURL:msg];
    
    if (url) {
        [[[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:@"打开", nil] show:^(NSInteger buttonIndex, UIAlertView *alertView){

            [_captureSession startRunning];
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
            
        }];
    }else {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        
        pasteboard.string = msg;
        
        [[[UIAlertView alloc] initWithTitle:msg message:@"内容已复制" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil] show:^(NSInteger buttonIndex, UIAlertView *alertView){
            
            [_captureSession startRunning];
            
        }];
    }
    
}

@end
