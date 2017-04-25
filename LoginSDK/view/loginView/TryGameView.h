//
//  TryView.h
//  LoginSDK
//
//  Created by admin on 2017/4/25.
//  Copyright © 2017年 TJ. All rights reserved.
//  一键试玩

#import <UIKit/UIKit.h>

typedef void(^completionBlock)(NSDictionary *dic);

@interface TryGameView : UIView

@property (nonatomic, copy) completionBlock completionBlock;

@end
