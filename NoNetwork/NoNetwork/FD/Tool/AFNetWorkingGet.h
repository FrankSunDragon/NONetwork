//
//  AFNetWorkingGet.h
//  Dronghui
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface AFNetWorkingGet : NSObject

/**
 * 3、无网络时的要弹出弹出框提醒
 *
 *  @param url *  @param isAlert      是否需要无网络是弹出框
 *  @param VC          在那个控制器里发起网络请求
 *  @param success     成功回调
 *  @param failure     失败回调
 *  @param IsAvailable 网络状况回调
 */
+ (void)GET_RequestWithAlertView:(NSString *)url isHUD:(BOOL)isNeedHUD isAlert:(BOOL)isAlert VC:(UIViewController *)VC completion:(void(^)(id result))success failure:(void (^)(NSError *error))failure connect:(void(^)(BOOL internet))IsAvailable;


@end
