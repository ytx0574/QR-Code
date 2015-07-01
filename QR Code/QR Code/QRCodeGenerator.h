//
//  QRCodeGenerator.h
//  TestApp
//
//  Created by Johnson on 7/1/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface QRCodeGenerator : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

+ (UIImage *)twoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage;

+ (BOOL)torchIsOn;

+ (void)openTorch:(BOOL)on;

- (CALayer *)showFromRect:(CGRect)rect inView:(UIView *)view complete:(void (^) (NSString *code))complete;

- (void)setRectOfInterest:(CGRect)rect;

@end
