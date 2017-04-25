//
//  PhoneLoginView.h
//  LoginSDK
//
//  Created by admin on 2017/4/25.
//  Copyright © 2017年 TJ. All rights reserved.
//  手机登录

#import <UIKit/UIKit.h>

typedef void(^completionBlock)(NSDictionary *dic);

@interface PhoneLoginView : UIView

@property (nonatomic, copy) completionBlock completionBlock;

@end
