//
//  FDNotInternetView.m
//  FTAgreement
//
//  Created by syf on 16/1/7.
//  Copyright © 2016年 SYF. All rights reserved.
//



#import "FDNotInternetView.h"
#import "Masonry.h"
@interface FDNotInternetView(){
    UIImageView * _alertIMg;// 没有网络的提示图片
    UILabel * _alertLab;
    UIButton * _alertBtn;
}
@end

@implementation FDNotInternetView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _alertIMg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nowang"]];
        [self addSubview:_alertIMg];
        [_alertIMg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(@(AdaptH(154)));
            make.width.equalTo(@154);
            make.height.equalTo(@102);
        }];
        
        _alertLab = [[UILabel alloc] init];
        _alertLab.font = [UIFont systemFontOfSize:14];
        _alertLab.userInteractionEnabled = YES;
        [_alertLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadNetworkDataSourcer)]];
        _alertLab.textAlignment = NSTextAlignmentCenter;
        _alertLab.textColor = DRHColor(153, 153, 153);
        _alertLab.text = @"亲,你的网络断开了~";
        [self addSubview:_alertLab];
        [_alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(_alertIMg.mas_bottom).with.offset(AdaptH(30));
            make.height.equalTo(@14);
            
        }];
        
        
        _alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alertBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_alertBtn setTitleColor:DRHColor(153, 153, 153) forState:UIControlStateNormal ];
        _alertBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_alertBtn addTarget:self action:@selector(reloadNetworkDataSourcer) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_alertBtn];
        [_alertBtn setExclusiveTouch:YES];
        [_alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_alertLab.mas_bottom).with.offset(0);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@26);
        }];
    }
    return self;
}

- (void)reloadNetworkDataSourcer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadNetworkDataSource:)]) {
        [self.delegate performSelector:@selector(reloadNetworkDataSource:) withObject:nil];
    }
}
@end
