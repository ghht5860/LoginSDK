//
//  BackgroundView.m
//  LoginSDK
//
//  Created by admin on 2017/2/23.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView ()

@end

@implementation BackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.userInteractionEnabled = YES;
    }
    return self;
}

////触摸开始触发该函数
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    
    [self endEditing:YES];
}

- (void)dealloc
{
    NSLog(@"释放%@",self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
