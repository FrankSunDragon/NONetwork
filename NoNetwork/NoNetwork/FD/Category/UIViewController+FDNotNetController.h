//
//  UIViewController+FDNotNetController.h
//  FTAgreement
//
//  Created by syf on 16/1/7.
//  Copyright © 2016年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDNotInternetView.h"
@interface UIViewController (FDNotNetController)<FDNotInternetViewDelegate,UIAlertViewDelegate>
/**
 *  为控制器扩展方法，刷新网络时候执行，建议必须实现
 */
- (void)reloadRequest;

/**
 *  显示没有网络
 */
- (void)showNonetWork;

/**
 *  隐藏没有网络
 */
- (void)hiddenNonetWork;


/// 但设备登录失败
- (void)alertUserISlodingAPP;
@end
