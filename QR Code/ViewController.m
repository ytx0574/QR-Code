//
//  ViewController.m
//  QR Code
//
//  Created by Johnson on 7/1/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
{
    QRCodeGenerator *qr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    qr = [[QRCodeGenerator alloc] init];
//    [qr showFromRect:self.view.bounds inView:self.view complete:^(NSString *code) {
//        
//    }];
//    
//    [QRCodeGenerator openTorch:YES];
//    
//    [QRCodeGenerator setVideoZoomFactor:1];
    
    
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 111, 320, 111)];
    [slider addTarget:self action:@selector(xx:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}

- (void)xx:(UISlider *)slider
{
    [QRCodeGenerator setVolume:slider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
