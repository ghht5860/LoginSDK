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
    
    NSString *str = nil;
    
    NSDictionary *dic = @{@"1":@"1",@"2":@" ",@"3":@"3",@"4":str == nil?@"":str};
    
    if (dic.allKeys.count < 3) {
        NSLog(@"信息缺失");
        return;
    }else {
        
        for (id obj in dic.allKeys) {
            NSLog(@"%@",dic[(NSString *)obj]);
            NSString *str = [dic[(NSString *)obj] stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (str.length <= 0) {
                NSLog(@"信息缺失");
                return;
            }
        }
    }
    
    
    return;
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *str = [NSString stringWithFormat:@"%@",obj];
        
        NSString *str1 = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (str1.length <= 0) {
            NSLog(@"%@:信息缺失",key);
        }
        
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
