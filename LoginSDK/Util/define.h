//
//  define.h
//  LoginSDK
//
//  Created by admin on 2017/4/24.
//  Copyright © 2017年 TJ. All rights reserved.
//

#ifndef define_h
#define define_h


#endif /* define_h */

#define Login_Account @"login_account"  //登陆账号
#define Login_Password @"login_password"    //登陆密码
//本地化账号
#define saveUser(user) [[NSUserDefaults standardUserDefaults] setObject:user forKey:Login_Account]

//获取本地账号
#define getUser [[NSUserDefaults standardUserDefaults] objectForKey:Login_Account]

//本地化密码
#define savePassword(password) [[NSUserDefaults standardUserDefaults] setObject:password forKey:Login_Password]

//获取本地账号
#define getPassword [[NSUserDefaults standardUserDefaults] objectForKey:Login_Password]

#define IMAGE_HEIGHT 700.f  //登陆界面原始高
#define IMAGE_WIDTH  870.f  //登陆界面原始宽

//#define STATUS_BAR_ORIENTATION @"StatusBarOrientation" //横竖屏状态
