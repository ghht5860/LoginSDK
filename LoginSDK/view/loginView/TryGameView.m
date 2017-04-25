//
//  TryView.m
//  LoginSDK
//
//  Created by admin on 2017/4/25.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "TryGameView.h"
#import "LoginApi.h"

@interface TryGameView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userTF;

@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UIButton *checkBoxBtn;

@end

@implementation TryGameView

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
    navTitle.text = @"一键试玩";
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
    
    //密码框左视图
    UILabel *passwordLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, userLeftLabel.frame.size.height)];
    passwordLeftLabel.text = @"密 码:";
    passwordLeftLabel.textAlignment = userLeftLabel.textAlignment;
    passwordLeftLabel.font = userLeftLabel.font;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = passwordLeftLabel;
    
    
    //同意复选框
    self.checkBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:self.checkBoxBtn];
    [self.checkBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *30);
        make.left.mas_equalTo(self.passwordTF.mas_left);
        make.width.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT *40);
        make.height.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT *40);
    }];
    [self.checkBoxBtn setImage:[UIImage imageNamed:@"口"] forState:UIControlStateNormal];
    [self.checkBoxBtn setImage:[UIImage imageNamed:@"口1"] forState:UIControlStateSelected];
    [self.checkBoxBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.checkBoxBtn.tag = 11;
    self.checkBoxBtn.selected = YES;
    
    //同意万家游戏用户条约
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:titleBtn];
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkBoxBtn.mas_top);
        make.left.mas_equalTo(self.checkBoxBtn.mas_right);
        make.bottom.mas_equalTo(self.checkBoxBtn.mas_bottom);
        make.width.mas_equalTo(160);
    }];
    [titleBtn setTitle:@"同意万家游戏用户条约" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
    [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = 12;
    
    //进入游戏
    UIButton *beginGameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:beginGameBtn];
    [beginGameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkBoxBtn.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *30);
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
    
    //手机登陆
    UIButton *phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:phoneLoginBtn];
    [phoneLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backView.mas_bottom);
        make.left.mas_equalTo(backView.mas_left);
        make.top.mas_equalTo(beginGameBtn.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *40);
        make.width.mas_equalTo(backView.frame.size.width/3);
    }];
    phoneLoginBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [phoneLoginBtn setTitle:@"手机登录" forState:UIControlStateNormal];
    [phoneLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneLoginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    phoneLoginBtn.tag = 14;
    
    //账号注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLoginBtn.mas_top);
        make.left.mas_equalTo(phoneLoginBtn.mas_right);
        make.bottom.mas_equalTo(phoneLoginBtn.mas_bottom);
        make.width.mas_equalTo(phoneLoginBtn.mas_width);
    }];
    registerBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [registerBtn setTitle:@"账号注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag = 15;
    
    //用户登陆
    UIButton *userLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:userLoginBtn];
    [userLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(registerBtn.mas_top);
        make.left.mas_equalTo(registerBtn.mas_right);
        make.right.mas_equalTo(backView.mas_right);
        make.bottom.mas_equalTo(registerBtn.mas_bottom);
    }];
    userLoginBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [userLoginBtn setTitle:@"已有账号" forState:UIControlStateNormal];
    [userLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [userLoginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    userLoginBtn.tag = 16;
    
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
            NSLog(@"阅读");
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
            NSLog(@"手机登录");
            [self removeFromSuperview];
            [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:4];
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
            NSLog(@"用户登录");
            [self removeFromSuperview];
            [[LoginApi sharedManage].loginModeSelectView setViewWithNumber:1];
            break;
        }
        default:
            break;
    }
}

//进入游戏
- (void)beginGameClick
{
    if (!self.checkBoxBtn.selected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请同意条款" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSDictionary *dic = @{@"user":self.userTF.text,@"password":self.passwordTF.text};
    if (self.completionBlock) {
        self.completionBlock(dic);
    }
    
    [[LoginApi sharedManage] removeLoginView];
    
    if (self.userTF.text.length > 0 && self.passwordTF.text.length > 0) {
        saveUser(self.userTF.text);
        savePassword(self.passwordTF.text);
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
