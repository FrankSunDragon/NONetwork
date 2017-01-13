//
//  DRHProgressHUD.m
//  DRHProduct
//
//  Created by Jacky Sun on 16/4/18.
//  Copyright © 2016年 马博. All rights reserved.
//

#import "DRHProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation DRHProgressHUD

+(void)FDShowClock:(NSString *)clock view:(UIView *)view{
    [self showError1:clock toView:view];

}


+(void)FDShowClock:(NSString *)clock
{
    [self showError1:clock toView:nil];
}

+ (void)showError1:(NSString *)error toView:(UIView *)view{
    [self show:error icon:nil view:view margin:11.0];
}


+ (void)FDDIsmiss
{
    
}


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view  margin:(CGFloat)margin
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
   // hud.yOffset = -AdaptH(110);
    // 设置图片
    if(icon.length>0)
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    hud.cornerRadius = 4.0;
    hud.margin = margin;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
   // hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
     [hud hide:YES afterDelay:1.8];
}

#pragma mark 显示一些信息
+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.margin = 12;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.cornerRadius = 3.0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:25];
 
    
}


+(void)FDShowText:(NSString *)message{
   return [self showMessage:message toView:nil];
}


+ (void)FDShowText:(NSString *)message view:(UIView *)view {
    return [self showMessage:message toView:view];
 
}



+ (void)FDDissHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)FDDissHUD
{
    [self FDDissHUDForView:nil];
}


+ (void)FDLoadingNetworkRequest:(UIView *)view{
        return [self showMessage:nil toView:view];
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:animated];
        return YES;
    }
    return NO;
}


+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}
@end
