//
//  AFNetWorkingGet.m
//  Dronghui
//
//

#import "AFNetWorkingGet.h"
#import <AFNetworking/AFNetworking.h>
#import "DRHProgressHUD.h"
#import "Reachability.h"
#import "UIViewController+FDNotNetController.h"


@implementation AFNetWorkingGet

+ (void)GET_RequestWithAlertView:(NSString *)url isHUD:(BOOL)isNeedHUD isAlert:(BOOL)isAlert VC:(UIViewController *)VC completion:(void (^)(id))success failure:(void (^)(NSError *))failure connect:(void (^)(BOOL))IsAvailable{
    
    
    //1. 检测网络
    BOOL intenet = [Reachability isMayUseInternet];
    
    if(IsAvailable){// 回调网络状态
        IsAvailable(intenet);
    }
    if(intenet){// M没有网
    [VC showNonetWork];

    if(isAlert)
     [DRHProgressHUD FDShowClock:@"网络不给力，请稍后再试"];
        return;
    }
    else{// 有网
        [VC hiddenNonetWork];
    }

    if(isNeedHUD)
    [DRHProgressHUD FDLoadingNetworkRequest:nil];
    
    //  创建请求管理
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    // 设置响应解析对象
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 支持类型
    [manage.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    
    // 设置超时时间
    
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manage.requestSerializer.timeoutInterval = 20;
    
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        if(isNeedHUD)
            [DRHProgressHUD FDDissHUD];
        
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(result);
        }else
            NSLog(@"data is empty");

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        if(isNeedHUD)
        [DRHProgressHUD FDDissHUD];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(isNeedHUD)
            [DRHProgressHUD FDShowClock:@"网络不给力，请稍后重试"];
            [VC showNonetWork];

        });

    }];

}

@end
