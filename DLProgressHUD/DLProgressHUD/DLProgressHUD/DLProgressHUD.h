//
//  DLProgressHUD.h
//  DLProgressHUD
//
//  Created by hcroad2 on 2017/6/7.
//  Copyright © 2017年 hcroad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLProgressView.h"
@interface DLProgressHUD : NSObject

+ (DLProgressHUD *)shareManager;

@property (nonatomic,strong) DLProgressView *dl_progressView;

@property (nonatomic,assign) DLProgressHUDType type;

- (void)showWithMessage:(NSString *)message type:(DLProgressHUDType)type;

- (void)dismissWithTime:(NSInteger )time;

@end
