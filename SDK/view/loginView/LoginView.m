//
//  LoginView.m
//  LoginSDK
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "LoginView.h"
#import "Masonry.h"
#import "LoginApi.h"

@interface LoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userTF;

@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self createLoginView];
    }
    return self;
}

- (void)createLoginView
{
    //登陆标题
    UIImageView *loginImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录底图"]];
    loginImage.userInteractionEnabled = YES;
    loginImage.frame = self.bounds;
    [self addSubview:loginImage];
    
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginImage addSubview:closeBtn];
    [closeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginImage.mas_top).offset(5);
        make.right.mas_equalTo(loginImage.mas_right).offset(-5);
        make.width.mas_equalTo(loginImage.frame.size.height/130.f *20 - 10);
        make.height.mas_equalTo(loginImage.frame.size.height/130.f *20 -10);
    }];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"close1"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeLoginView) forControlEvents:UIControlEventTouchUpInside];
    
    //账号
    self.userTF = [UITextField new];
    [loginImage addSubview:self.userTF];
    [self.userTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(closeBtn.mas_bottom).offset(loginImage.frame.size.height/695.f *55);
        make.left.mas_equalTo(loginImage.mas_left).offset(loginImage.frame.size.width/870.f *24);
        make.right.mas_equalTo(loginImage.mas_right).offset(-(loginImage.frame.size.width/870.f *24));
        make.height.mas_equalTo(loginImage.frame.size.height/695.f *130);
    }];
    //    self.userTF.clearButtonMode = UITextFieldViewModeAlways;
    self.userTF.background = [UIImage imageNamed:@"输入框1"];
    self.userTF.delegate = self;
    [self.userTF becomeFirstResponder];
    
    //账号框左视图
    UILabel *userLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, loginImage.frame.size.height/695.f *130)];
    userLeftLabel.text = @"账 号:";
    userLeftLabel.textAlignment = NSTextAlignmentCenter;
    userLeftLabel.font = [UIFont systemFontOfSize:18.f];
    self.userTF.leftViewMode = UITextFieldViewModeAlways;
    self.userTF.leftView  = userLeftLabel;
    
    //账号右按钮
    UIView *userRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, loginImage.frame.size.height/695.f *130 /2 +10, loginImage.frame.size.height/695.f *130)];
    
    UIButton *userRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userRightBtn.frame = CGRectMake(0, 0, loginImage.frame.size.height/695.f *130 /3, loginImage.frame.size.height/695.f *130 /3);
    userRightBtn.center = userRightView.center;
    [userRightBtn setImage:[UIImage imageNamed:@"clear1"] forState:UIControlStateNormal];
    [userRightBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
    userRightBtn.tag = 1;
    [userRightBtn addTarget:self action:@selector(clearTextFieldText:) forControlEvents:UIControlEventTouchUpInside];
    [userRightView addSubview:userRightBtn];
    
    self.userTF.rightViewMode = UITextFieldViewModeAlways;
    self.userTF.rightView = userRightView;
    
    //密码框
    self.passwordTF = [UITextField new];
    [loginImage addSubview:self.passwordTF];
    [self.passwordTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userTF.mas_bottom).offset(loginImage.frame.size.height/695.f *30);
        make.left.mas_equalTo(self.userTF.mas_left);
        make.right.mas_equalTo(self.userTF.mas_right);
        make.height.mas_equalTo(self.userTF.mas_height);
    }];
    //    self.passwordTF.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.passwordTF.background = [UIImage imageNamed:@"输入框1"];
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.delegate = self;
    
    //密码框左视图
    UILabel *passwordLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, userLeftLabel.frame.size.height)];
    passwordLeftLabel.text = @"密 码:";
    passwordLeftLabel.textAlignment = userLeftLabel.textAlignment;
    passwordLeftLabel.font = userLeftLabel.font;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = passwordLeftLabel;
    
    //密码框右视图
    UIView *passwordRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, loginImage.frame.size.height/695.f *130 /3 +70, loginImage.frame.size.height/695.f *130)];
    
    UIButton *passwordClearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordRightView addSubview:passwordClearBtn];
    [passwordClearBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordRightView.mas_left);
        make.centerY.mas_equalTo(passwordRightView.mas_centerY);
        make.width.mas_equalTo(loginImage.frame.size.height/695.f *130 /3);
        make.height.mas_equalTo(loginImage.frame.size.height/695.f *130 /3);
    }];
    [passwordClearBtn setImage:[UIImage imageNamed:@"clear1"] forState:UIControlStateNormal];
    [passwordClearBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
    passwordClearBtn.tag = 2;
    [passwordClearBtn addTarget:self action:@selector(clearTextFieldText:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *passwordRightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    passwordRightBtn.frame = CGRectMake(loginImage.frame.size.height/695.f *130 /3, 0, 70, passwordLeftLabel.frame.size.height);
    [passwordRightBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [passwordRightBtn setTitleColor:[UIColor colorWithRed:45/255.f green:114/255.f blue:207/255.f alpha:1.0] forState:UIControlStateNormal];
    [passwordRightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    [passwordRightBtn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [passwordRightView addSubview:passwordRightBtn];
    
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    self.passwordTF.rightView = passwordRightView;
    
    
    //快速注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginImage addSubview:registerBtn];
    [registerBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(loginImage.frame.size.height/695.f *55);
        make.left.mas_equalTo(self.passwordTF.mas_left);
        make.right.mas_equalTo(loginImage.mas_centerX).offset(-(loginImage.frame.size.height/870.f *14));
        make.height.mas_equalTo(self.passwordTF.mas_height);
    }];
    [registerBtn setImage:[UIImage imageNamed:@"立即注册"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //立即登录
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginImage addSubview:loginBtn];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(registerBtn.mas_top);
        make.left.mas_equalTo(loginImage.mas_centerX).offset(loginImage.frame.size.height/870.f *14);
        make.right.mas_equalTo(self.passwordTF.mas_right);
        make.bottom.mas_equalTo(registerBtn.mas_bottom);
    }];
    [loginBtn setImage:[UIImage imageNamed:@"立即登录"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
}

//清除输入框内容
- (void)clearTextFieldText:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
            self.userTF.text = @"";
            break;
        case 2:
            self.passwordTF.text = @"";
            break;
        default:
            break;
    }
}

//忘记密码
- (void)forgetPassword:(UIButton *)btn
{
    NSLog(@"忘记密码");
}

//立即注册
- (void)registerClick:(UIButton *)btn
{
    NSLog(@"立即注册");
    [self removeFromSuperview];
    [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:2];
}

//立即登录
- (void)loginClick:(UIButton *)btn
{
    NSLog(@"立即登录");
    NSDictionary *dic = @{@"user":self.userTF.text,@"password":self.passwordTF.text};
    if (self.completionBlock) {
        self.completionBlock(dic);
    }
    
    [[LoginApi sharedManage] removeLoginView];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.userTF.background = [UIImage imageNamed:@"输入框1"];
    self.passwordTF.background = [UIImage imageNamed:@"输入框1"];
    
    textField.background = [UIImage imageNamed:@"输入框"];
    
    return YES;
}

//关闭
- (void)closeLoginView
{
    [[LoginApi sharedManage] removeLoginView];
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
