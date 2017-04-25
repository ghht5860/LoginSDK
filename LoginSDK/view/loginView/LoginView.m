//
//  LoginView.m
//  LoginSDK
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "LoginView.h"
#import "LoginApi.h"

@interface LoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userTF;

@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UIButton *rememberPw;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self createNewLoginView];
    }
    return self;
}


- (void)createNewLoginView
{
    //背景图
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 8.f;
    backView.clipsToBounds = YES;
    [self addSubview:backView];
    
    //标题
    UILabel *navTitle = [UILabel new];
    [backView addSubview:navTitle];
    [navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top);
        make.left.mas_equalTo(backView.mas_left);
        make.right.mas_equalTo(backView.mas_right);
        make.height.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT * 100);
    }];
    navTitle.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    navTitle.text = @"用户登录";
    navTitle.textColor = [UIColor redColor];
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(navTitle.mas_top);
        make.right.mas_equalTo(navTitle.mas_right);
        make.bottom.mas_equalTo(navTitle.mas_bottom);
        make.width.mas_equalTo(navTitle.mas_height);
    }];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeLoginView) forControlEvents:UIControlEventTouchUpInside];
    
    //账号
    self.userTF = [UITextField new];
    [backView addSubview:self.userTF];
    [self.userTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(navTitle.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *50);
        make.left.mas_equalTo(backView.mas_left).offset(backView.frame.size.width/IMAGE_WIDTH *25);
        make.right.mas_equalTo(backView.mas_right).offset(-(backView.frame.size.width/IMAGE_WIDTH *25));
        make.height.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT *100);
    }];
    self.userTF.clearButtonMode = UITextFieldViewModeAlways;
    self.userTF.background = [UIImage imageNamed:@"输入框1"];
    self.userTF.delegate = self;
    self.userTF.text = getUser;
    if (self.userTF.text.length == 0) {
        [self.userTF becomeFirstResponder];
    }
    
    //账号框左视图
    UILabel *userLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, backView.frame.size.height/IMAGE_HEIGHT *100)];
    userLeftLabel.text = @"账 号:";
    userLeftLabel.textAlignment = NSTextAlignmentCenter;
    userLeftLabel.font = [UIFont systemFontOfSize:15.f];
    self.userTF.leftViewMode = UITextFieldViewModeAlways;
    self.userTF.leftView  = userLeftLabel;
    
    //密码
    self.passwordTF = [UITextField new];
    [backView addSubview:self.passwordTF];
    [self.passwordTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userTF.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *30);
        make.left.mas_equalTo(self.userTF.mas_left);
        make.right.mas_equalTo(self.userTF.mas_right);
        make.height.mas_equalTo(self.userTF.mas_height);
    }];
    self.passwordTF.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTF.background = [UIImage imageNamed:@"输入框1"];
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.delegate = self;
    self.passwordTF.text = getPassword;
    
    //密码框左视图
    UILabel *passwordLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, userLeftLabel.frame.size.height)];
    passwordLeftLabel.text = @"密 码:";
    passwordLeftLabel.textAlignment = userLeftLabel.textAlignment;
    passwordLeftLabel.font = userLeftLabel.font;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = passwordLeftLabel;
    
    
    //记住密码
    self.rememberPw = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:self.rememberPw];
    [self.rememberPw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *30);
        make.left.mas_equalTo(self.passwordTF.mas_left);
        make.width.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT *40);
        make.height.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT *40);
    }];
    [self.rememberPw setImage:[UIImage imageNamed:@"口"] forState:UIControlStateNormal];
    [self.rememberPw setImage:[UIImage imageNamed:@"口1"] forState:UIControlStateSelected];
    [self.rememberPw addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rememberPw.tag = 11;
    self.rememberPw.selected = YES;
    
    //记住密码
    UILabel *title1 = [UILabel new];
    [backView addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rememberPw.mas_top);
        make.left.mas_equalTo(self.rememberPw.mas_right).offset(5);
        make.bottom.mas_equalTo(self.rememberPw.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    title1.text = @"记住密码";
    title1.font = [UIFont systemFontOfSize:14.f];
    
    //忘记密码
    UIButton *forgetPw = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:forgetPw];
    [forgetPw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rememberPw.mas_top);
        make.right.mas_equalTo(self.passwordTF.mas_right);
        make.bottom.mas_equalTo(self.rememberPw.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"忘记密码" attributes:attribtDic];
    [forgetPw setAttributedTitle:attribtStr forState:UIControlStateNormal];
    [forgetPw addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetPw.tag = 12;
    
    //进入游戏
    UIButton *beginGameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:beginGameBtn];
    [beginGameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rememberPw.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *30);
        make.left.mas_equalTo(self.passwordTF.mas_left);
        make.right.mas_equalTo(self.passwordTF.mas_right);
        make.height.mas_equalTo(self.passwordTF.mas_height);
    }];
    beginGameBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [beginGameBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginGameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    beginGameBtn.layer.cornerRadius = 5.f;
    [beginGameBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    beginGameBtn.tag = 13;
    
    //一键试玩
    UIButton *tryGameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:tryGameBtn];
    [tryGameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backView.mas_bottom);
        make.left.mas_equalTo(backView.mas_left);
        make.top.mas_equalTo(beginGameBtn.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *40);
        make.width.mas_equalTo(backView.frame.size.width/3);
    }];
    tryGameBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [tryGameBtn setTitle:@"一键试玩" forState:UIControlStateNormal];
    [tryGameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tryGameBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    tryGameBtn.tag = 14;
    
    //账号注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tryGameBtn.mas_top);
        make.left.mas_equalTo(tryGameBtn.mas_right);
        make.bottom.mas_equalTo(tryGameBtn.mas_bottom);
        make.width.mas_equalTo(tryGameBtn.mas_width);
    }];
    registerBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [registerBtn setTitle:@"账号注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag = 15;
    
    //手机登陆
    UIButton *phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:phoneLoginBtn];
    [phoneLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(registerBtn.mas_top);
        make.left.mas_equalTo(registerBtn.mas_right);
        make.right.mas_equalTo(backView.mas_right);
        make.bottom.mas_equalTo(registerBtn.mas_bottom);
    }];
    phoneLoginBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [phoneLoginBtn setTitle:@"手机登录" forState:UIControlStateNormal];
    [phoneLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneLoginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    phoneLoginBtn.tag = 16;
    
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

//按钮点击
- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 11:
        {
            btn.selected = !btn.selected;
            break;
        }
        case 12:
        {
            NSLog(@"忘记密码");
            break;
        }
        case 13:
        {
            NSLog(@"进入游戏");
            [self beginGameClick];
            break;
        }
        case 14:
        {
            NSLog(@"一键试玩");
            [self removeFromSuperview];
            [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:3];
            break;
        }
        case 15:
        {
            NSLog(@"账号注册");
            [self removeFromSuperview];
            [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:2];
            break;
        }
        case 16:
        {
            NSLog(@"手机登陆");
            [self removeFromSuperview];
            [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:4];
            break;
        }
        default:
            break;
    }
}

//进入游戏
- (void)beginGameClick
{
    NSDictionary *dic = @{@"user":self.userTF.text,@"password":self.passwordTF.text,@"isRememberPW":[NSString stringWithFormat:@"%d",(self.rememberPw.selected == YES?1:0)]};
    if (self.completionBlock) {
        self.completionBlock(dic);
    }
    
    [[LoginApi sharedManage] removeLoginView];
    
    if (self.userTF.text.length > 0 && self.passwordTF.text.length > 0) {
        saveUser(self.userTF.text);
        if (self.rememberPw.selected) {
            savePassword(self.passwordTF.text);
        }else {
            savePassword(@"");
        }
    }
    
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
