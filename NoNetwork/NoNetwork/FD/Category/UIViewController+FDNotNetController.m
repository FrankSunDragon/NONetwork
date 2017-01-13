//
//  UIViewController+FDNotNetController.m
//  FTAgreement
//
//  Created by syf on 16/1/7.
//  Copyright © 2016年 SYF. All rights reserved.
//

#import "UIViewController+FDNotNetController.h"
#import "FDNotInternetView.h"
@implementation UIViewController (FDNotNetController)

- (void)showNonetWork
{
    NSInteger tag = 0;
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[FDNotInternetView class]]) {
            tag++;
        }
    }
    if(tag>0)
        return;
    CGFloat YY = 64;
    if([self isKindOfClass:[UITableViewController class]]){
        UITableViewController * tab = (UITableViewController *)self;
        tab.tableView.scrollEnabled = NO;
        YY = 0;
    }
 
    FDNotInternetView  * view = [[FDNotInternetView alloc] initWithFrame:CGRectMake(0, YY, SCREEN_WIDTH, SCREEN_HEIGHT-YY)];
    view.delegate = self;
    
    [self.view addSubview:view];
}
- (void)hiddenNonetWork
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[FDNotInternetView class]]) {
            if([self isKindOfClass:[UITableViewController class]]){
                UITableViewController * tab = (UITableViewController *)self;
                tab.tableView.scrollEnabled = YES;
            }
            [view removeFromSuperview];
        }
    }
}
- (void)reloadNetworkDataSource:(id)sender
{
    if ([self respondsToSelector:@selector(reloadRequest)]) {
        [self performSelector:@selector(reloadRequest)];
    }
}

- (void)reloadRequest
{
    NSLog(@"必须由网络控制器(%@)重写这个方法(%@)，才可以使用再次刷新网络",NSStringFromClass([self class]),NSStringFromSelector(@selector(reloadRequest)));
}


- (void)alertUserISlodingAPP{
//  UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"您已退出当前账号" message:@"您的账号已经在其他设备上登录，当前设备账号被迫退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
//    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[FDIMGBarController alloc] init];
//    
//    if(buttonIndex == 0){
//        
//    }
//    else{
//   
//    }
}

@end
