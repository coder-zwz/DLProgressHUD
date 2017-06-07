//
//  DLProgressView.h
//  DLProgressHUD
//
//  Created by hcroad2 on 2017/6/7.
//  Copyright © 2017年 hcroad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS (NSInteger ,DLProgressHUDType)
{
    DLProgressHUDTypeLoading = 0,
    DLProgressHUDTypeSuccess = 1,
    DLProgressHUDTypeError   = 2,
    DLProgressHUDTypeMessage = 3
};

@interface DLProgressView : UIView

@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) DLProgressHUDType hudViewType;

- (instancetype)init;

- (void)hudShowWithType:(DLProgressHUDType)hudViewType message:(NSString *)message;

- (void)show;

- (void)dismiss;

@end
