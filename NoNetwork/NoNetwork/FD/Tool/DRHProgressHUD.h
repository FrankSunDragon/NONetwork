//
//  DRHProgressHUD.h
//  DRHProduct
//
//  Created by Jacky Sun on 16/4/18.
//  Copyright © 2016年 马博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DRHProgressHUD : NSObject

/// 弹出框提醒
+(void)FDShowClock:(NSString *)clock;

+(void)FDShowClock:(NSString *)clock view:(UIView *)view;


+ (void)FDShowText:(NSString *)message;
+ (void)FDLoadingNetworkRequest:(UIView *)view;

+ (void)FDShowText:(NSString *)message view:(UIView *)view;


+ (void)FDDissHUDForView:(UIView *)view;
+ (void)FDDissHUD;

@end
