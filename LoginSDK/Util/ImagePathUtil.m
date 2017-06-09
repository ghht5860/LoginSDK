//
//  ImagePathUtil.m
//  Payment
//
//  Created by 朱进 on 16/4/14.
//  Copyright © 2016年 朱进. All rights reserved.
//

#import "ImagePathUtil.h"

@implementation ImagePathUtil

+(NSString *)getKaYiKaImageBundlePath:(NSString *)filename {
    NSString *strBundle = [[NSBundle mainBundle] pathForResource:@"TJLoginSDK" ofType:@"bundle"];
    
    if (strBundle && filename) {
        // 找到对应images夹下的图片
        NSString *path1 = [[NSBundle bundleWithPath:strBundle] pathForResource:filename ofType:@"png" inDirectory:@"image"];
        return path1;
        
    }else{
        NSLog(@"print path1 is null");
    }
    return nil;
}

@end
