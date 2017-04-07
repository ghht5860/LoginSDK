//
//  LoginView.h
//  LoginSDK
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^completionBlock)(NSDictionary *dic);

@interface LoginView : UIView

@property (nonatomic, copy) completionBlock completionBlock;

@end
