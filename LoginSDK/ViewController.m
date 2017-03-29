//
//  ViewController.m
//  LoginSDK
//
//  Created by admin on 2017/2/23.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "ViewController.h"
#import "LoginApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 80, 50);
    btn.center = self.view.center;
    [btn setTitle:@"弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)a:(id)sender
{
    [[LoginApi sharedManage] addLoginViewWithSuperView:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
