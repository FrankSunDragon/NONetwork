//
//  ViewController.m
//  NoNetwork
//
//  Created by Jacky Sun on 2017/1/13.
//  Copyright © 2017年 syf. All rights reserved.
//

#import "ViewController.h"
#import "AFNetWorkingGet.h"
#import "UIViewController+FDNotNetController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无网络界面";
    [self HttpRequestForMyMessage];
}

- (void)HttpRequestForMyMessage{
    [AFNetWorkingGet GET_RequestWithAlertView:DefaulMessage isHUD:YES isAlert:YES VC:self completion:^(id result) {
        
        if([result[@"Success"] boolValue]){
            _dataArray = result[@"Data"][@"Items"];
            [_tableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
    } connect:^(BOOL internet) {
        
    }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary * dict = _dataArray[indexPath.row];
    cell.textLabel.text = dict[@"Name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)reloadRequest{
    [self HttpRequestForMyMessage];
}

@end
