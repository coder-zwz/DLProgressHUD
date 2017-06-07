//
//  DLProgressHUD.m
//  DLProgressHUD
//
//  Created by hcroad2 on 2017/6/7.
//  Copyright © 2017年 hcroad. All rights reserved.
//

#import "DLProgressHUD.h"

@implementation DLProgressHUD

+ (DLProgressHUD *)shareManager
{
    static DLProgressHUD *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[DLProgressHUD alloc]init];
        shareManager.dl_progressView = [[DLProgressView alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:shareManager.dl_progressView];
    });
    return shareManager;
}

- (void)showWithMessage:(NSString *)message type:(DLProgressHUDType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dl_progressView show];
        [self.dl_progressView hudShowWithType:type message:message];
    });
}
- (void)dismissWithTime:(NSInteger)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dl_progressView dismiss];
        });
    });
    
}

@end
