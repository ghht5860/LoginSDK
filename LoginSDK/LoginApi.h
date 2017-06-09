//
//  LoginApi.h
//  LoginSDK
//
//  Created by admin on 2017/2/23.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BackgroundView;
@class LoginModeSelectView;

@interface LoginApi : NSObject

@property (nonatomic, strong) BackgroundView *backgroundView; //全屏背景图

@property (nonatomic, strong) LoginModeSelectView *loginModeSelectView; //登陆框父视图

@property (nonatomic, assign) BOOL isPortrait; // 横竖屏状态 YES:竖屏 NO:横屏

/**
 单例化权限狗

 @return 获取初始化完的权限狗
 */
+ (instancetype)sharedManage;

/**
 加载登陆窗口

 @param superView 父类试图
 */
- (void)showLoginViewWithSuperView:(UIView *)superView;


/**
 删除登陆窗口
 */
- (void)removeLoginView;

/**
 获取屏幕横竖状态

 @return 返回Home键再手机的位置
 */
- (UIInterfaceOrientation)getStatusBarOrientation;

@end
