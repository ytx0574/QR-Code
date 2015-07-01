//
//  QRCodeGenerator.h
//  TestApp
//
//  Created by Johnson on 7/1/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface QRCodeGenerator : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

+ (UIImage *)twoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage;

+ (BOOL)torchIsOn;

+ (void)openTorch:(BOOL)on;

+ (void)setVideoZoomFactor:(CGFloat)factor;


- (CALayer *)showFromRect:(CGRect)rect inView:(UIView *)view complete:(void (^) (NSString *code))complete;

- (void)setRectOfInterest:(CGRect)rect;

@end
