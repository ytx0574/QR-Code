//
//  UIAlertView+Tools.m
//  Het
//
//  Created by Johnson on 15/3/25.
//  Copyright (c) 2015年 pretang. All rights reserved.
//

#import "UIAlertView+Tools.h"
#import <objc/runtime.h>

@interface UIAlertView () <UIAlertViewDelegate>
@property (nonatomic, copy) void(^complete)(NSInteger buttonIndex, UIAlertView *alertView);
@end

@implementation UIAlertView (Tools)

static char AlertViewCompleteKey;

#pragma mark - Methods
- (void)show:(void(^)(NSInteger buttonIndex, UIAlertView *alertView))complete
{
    self.delegate = self;
    self.complete = complete;
    [self show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    self.complete ? self.complete(buttonIndex, alertView) : nil;
}

#pragma mark - SetMethods
- (void)setComplete:(void (^)(NSInteger buttonIndex, UIAlertView *alertView))complete
{
    objc_setAssociatedObject(self, &AlertViewCompleteKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - GetMethods
- (void(^)(NSInteger buttonIndex, UIAlertView *alertView))complete
{
    return objc_getAssociatedObject(self, &AlertViewCompleteKey);
}

@end