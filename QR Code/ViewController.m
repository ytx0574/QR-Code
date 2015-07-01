//
//  ViewController.m
//  QR Code
//
//  Created by Johnson on 7/1/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"

@interface ViewController ()
{
    QRCodeGenerator *qr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    qr = [[QRCodeGenerator alloc] init];
    [qr showFromRect:self.view.bounds inView:self.view complete:^(NSString *code) {
        
    }];
    
    [QRCodeGenerator openTorch:YES];
    
//    [qr setRectOfInterest:CGRectMake(.5, .5, .5, .5)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
