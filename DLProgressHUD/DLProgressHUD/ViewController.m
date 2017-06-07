//
//  ViewController.m
//  DLProgressHUD
//
//  Created by hcroad2 on 2017/6/7.
//  Copyright © 2017年 hcroad. All rights reserved.
//

#import "ViewController.h"
#import "DLProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)showHUD:(id)sender
{
    [[DLProgressHUD shareManager] showWithMessage:@"加载中..." type:DLProgressHUDTypeLoading];
}
- (IBAction)dismiss:(id)sender
{
    [[DLProgressHUD shareManager] dismissWithTime:0];
}
- (IBAction)showAlert:(id)sender {
    [[DLProgressHUD shareManager] showWithMessage:@"Success!" type:DLProgressHUDTypeSuccess];
}
- (IBAction)dismissAlert:(id)sender {
    [[DLProgressHUD shareManager] dismissWithTime:1];
}
- (IBAction)error:(id)sender {
    [[DLProgressHUD shareManager] showWithMessage:@"Error!" type:DLProgressHUDTypeError];
}
- (IBAction)message:(id)sender {
    [[DLProgressHUD shareManager] showWithMessage:@"Message..." type:DLProgressHUDTypeMessage];
}

@end
