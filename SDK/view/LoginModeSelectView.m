//
//  LoginModeSelectView.m
//  LoginSDK
//
//  Created by admin on 2017/2/23.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "LoginModeSelectView.h"
#import "LoginApi.h"
#import "Masonry.h"
#import "LoginView.h"
#import "RegisterView.h"

@interface LoginModeSelectView ()
{
    completionBlock loginCompletion;
    completionBlock registerCompletion;
}
@end

@implementation LoginModeSelectView

- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)showSelectViewWithSuperView:(UIView *)superView
{
    if ([LoginApi sharedManage].isPortrait) {
        self.frame = CGRectMake(0, 0, superView.frame.size.width - 50, (superView.frame.size.width - 50) /5.f *4);
        self.center = superView.center;
    }else {
        self.frame = CGRectMake(0, 0, superView.frame.size.height - 5, (superView.frame.size.height - 5) /5.f *4);
        self.center = superView.center;
    }
    [superView addSubview:self];
    self.alpha = 0;
    
    [self setBackView];
}

- (void)setBackView
{
    //窗口效果
    self.backgroundColor = [UIColor clearColor];
    
    //阴影层
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5.f;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
    
    [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:1];
}

//内容层
- (void)setViewWithNumber:(int)number
{
    switch (number) {
        case 1:
        {
            //登陆
            loginCompletion = ^(NSDictionary *dic) {
                NSLog(@"%@",dic);
            };
            LoginView *loginView = [[LoginView alloc] initWithFrame:self.bounds];
            loginView.completionBlock = loginCompletion;
            [self addSubview:loginView];
            break;
        }
        case 2:
        {
            //注册
            registerCompletion = ^(NSDictionary *dic) {
                NSLog(@"%@",dic);
            };
            RegisterView *registerView = [[RegisterView alloc] initWithFrame:self.bounds];
            registerView.completionBlock = registerCompletion;
            [self addSubview:registerView];
            break;
        }
        default:
            break;
    }
    

    //显示动画
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
    }];
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
