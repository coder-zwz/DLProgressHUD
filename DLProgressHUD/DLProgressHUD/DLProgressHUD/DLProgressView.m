//
//  DLProgressView.m
//  DLProgressHUD
//
//  Created by hcroad2 on 2017/6/7.
//  Copyright © 2017年 hcroad. All rights reserved.
//

#import "DLProgressView.h"
#import "DLLabel.h"
#import "UIColor+Hexadecimal.h"

#define FONT_SIZE 14
#define HUD_WIDTH 200
#define HUD_HEIGHT 50
#define ICON_WIDTH 50

@interface DLProgressView ()

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) DLLabel *tipsLabel;

@end

@implementation DLProgressView

- (UIImageView *)icon
{
    if (_icon == nil)
    {
        _icon = [[UIImageView alloc]init];
        _icon.frame = CGRectMake(0, 0, 40, 40);
    }
    return _icon;
}

- (DLLabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[DLLabel alloc]init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _tipsLabel;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

#pragma mark 设置self的layer
- (void)resetLayer
{
    self.layer.shadowColor      = [UIColor blackColor].CGColor;
    self.layer.shadowOffset     = CGSizeMake(0, 0);
    self.layer.shadowRadius     = 5;
    self.layer.cornerRadius     = 5;
    self.layer.shadowOpacity    = 1;
}

#pragma mark 设置type
- (void)hudShowWithType:(DLProgressHUDType)hudViewType message:(NSString *)message
{
    [self resetFrameWithMessage:message];
    [self resetLayer];
    
    switch (hudViewType) {
        case DLProgressHUDTypeLoading:
        {
            [self showLoadingAnimation];
            self.icon.image = [UIImage imageNamed:@"loading_1"];
        }
            break;
        case DLProgressHUDTypeSuccess:
        {
            [self.icon.layer removeAllAnimations];
            self.icon.image = [UIImage imageNamed:@"success_1"];
        }
            break;
        case DLProgressHUDTypeError:
        {
            [self.icon.layer removeAllAnimations];
            self.icon.image = [UIImage imageNamed:@"error_1"];
        }
            break;
        case DLProgressHUDTypeMessage:
        {
            [self.icon.layer removeAllAnimations];
            self.icon.image = [UIImage imageNamed:@"message_1"];
        }
            break;
        default:
            break;
    }
}


#pragma mark 设置各个控件的frame
- (void)resetFrameWithMessage:(NSString *)message
{
    CGSize labelSize = [self getTheRealHeightAndWidthWithMessage:message];
    if (labelSize.height <= HUD_WIDTH)
    {
        if (self.tipsLabel.numberOfLines > 1)
        {
            self.tipsLabel.frame = CGRectMake(ICON_WIDTH, 0, HUD_WIDTH, labelSize.height);
            self.tipsLabel.center = CGPointMake(ICON_WIDTH + HUD_WIDTH/2, 25);
            self.icon.center = CGPointMake(25, 25);
            self.frame = CGRectMake(0, 0, HUD_WIDTH + ICON_WIDTH, HUD_HEIGHT);
        }
        else
        {
            self.tipsLabel.frame = CGRectMake(ICON_WIDTH, 0, HUD_WIDTH, labelSize.height);
            self.tipsLabel.center =CGPointMake(ICON_WIDTH + labelSize.width/2, 25);
            self.icon.center = CGPointMake(25, 25);
            self.frame = CGRectMake(0, 0, labelSize.width + ICON_WIDTH, HUD_HEIGHT);
        }
    }
    else
    {
        self.tipsLabel.frame = CGRectMake(ICON_WIDTH, 0, HUD_WIDTH, labelSize.height);
        self.tipsLabel.center = CGPointMake(ICON_WIDTH + labelSize.width/2, labelSize.height/2);
        self.icon.center = CGPointMake(25, labelSize.height/2);
        self.frame = CGRectMake(0, 0, labelSize.width + ICON_WIDTH, labelSize.height);
    }
    
    
    self.tipsLabel.text = message;
    [self addSubview:self.tipsLabel];
    [self addSubview:self.icon];
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    self.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
    
}

#pragma mark 根据文字返回动态的宽度和高度
- (CGSize )getTheRealHeightAndWidthWithMessage:(NSString *)message
{
    CGSize labelSize        = [message boundingRectWithSize:CGSizeMake(HUD_WIDTH - (self.tipsLabel.edgeInsets.left + self.tipsLabel.edgeInsets.right) , MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
                                                    context:nil].size;
    CGFloat realHeight      = (HUD_WIDTH  * (labelSize.height + self.tipsLabel.edgeInsets.top + self.tipsLabel.edgeInsets.bottom))/HUD_WIDTH;
    CGFloat realWidth = labelSize.width + self.tipsLabel.edgeInsets.left + self.tipsLabel.edgeInsets.right;
    CGSize size = CGSizeMake(realWidth, realHeight);
    return size;
}

#pragma mark 动画
- (void)showLoadingAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setToValue:@(M_PI * 2)];
    [animation setRepeatDuration:MAXFLOAT];
    [animation setDuration:1.0f];
    [animation setRemovedOnCompletion:NO];
    [self.icon.layer addAnimation:animation forKey:@"animationKeyOne"];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.layer.hidden = NO;
    self.alpha = 1.0f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setFromValue:@(1.0f)];//1.缩放的开始值
    [animation setToValue:@(0.97f)];//2.所要缩放到的值
    [animation setAutoreverses:YES];//3.是否原路返回
    [animation setDuration:0.618f];//4.动画时长
    [animation setRepeatDuration:MAXFLOAT];//5.动画重复次数
    [self.layer addAnimation:animation forKey:@"show"];
    [animation setRemovedOnCompletion:YES];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
