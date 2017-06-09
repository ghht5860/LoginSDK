//
//  LoginApi.m
//  LoginSDK
//
//  Created by admin on 2017/2/23.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "LoginApi.h"
#import "BackgroundView.h"
#import "LoginModeSelectView.h"

@interface LoginApi ()
{
    UIWindow *window;
}

@end

@implementation LoginApi

- (instancetype)init
{
    if (self = [super init]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    return self;
    
}

static LoginApi *apiManage = nil;
+ (instancetype)sharedManage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManage = [[LoginApi alloc] init];
    });
    return apiManage;
}

- (void)showLoginViewWithSuperView:(UIView *)superView
{
    [self getStatusBarOrientation];
    
    if (superView == nil) {
        [window addSubview:self.backgroundView];
    }else {
        [superView addSubview:self.backgroundView];
    }
    [self.loginModeSelectView showSelectViewWithSuperView:self.backgroundView];
    
}

- (void)removeLoginView
{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.backgroundView) {
            self.backgroundView.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if (self.backgroundView) {
            [self.backgroundView removeFromSuperview];
            self.loginModeSelectView = nil;
            self.backgroundView = nil;
        }
    }];
}

- (BackgroundView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[BackgroundView alloc] initWithFrame:window.rootViewController.view.bounds];
    }
    return _backgroundView;
}

- (LoginModeSelectView *)loginModeSelectView
{
    if (_loginModeSelectView == nil) {
        _loginModeSelectView = [[LoginModeSelectView alloc] init];
    }
    return _loginModeSelectView;
}


-(UIInterfaceOrientation)getStatusBarOrientation
{
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"UIInterfaceOrientationPortrait");
            self.isPortrait = YES;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
            self.isPortrait = YES;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"UIInterfaceOrientationLandscapeLeft");
            self.isPortrait = NO;
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"UIInterfaceOrientationLandscapeRight");
            self.isPortrait = NO;
            break;
        default:
            break;
    }
    NSLog(@"%@",self.isPortrait?@"竖屏":@"横屏");
    return [UIApplication sharedApplication].statusBarOrientation;
}

@end
