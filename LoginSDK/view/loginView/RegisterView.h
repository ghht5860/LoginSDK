//
//  RegisterView.h
//  LoginSDK
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 TJ. All rights reserved.
//  账号注册

#import <UIKit/UIKit.h>

typedef void(^completionBlock)(NSDictionary *dic);

@interface RegisterView : UIView

@property (nonatomic, copy) completionBlock completionBlock;

@end
