//
//  FDNotInternetView.h
//  FTAgreement
//
//  Created by syf on 16/1/7.
//  Copyright © 2016年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FDNotInternetViewDelegate  <NSObject>

- (void)reloadNetworkDataSource:(id)sender;

@end
@interface FDNotInternetView : UIView

/**
 *  由代理控制器去执行刷新网络
 */
@property (nonatomic, weak) id<FDNotInternetViewDelegate>delegate;
@end
