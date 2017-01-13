![](http://upload-images.jianshu.io/upload_images/1163208-50bd43907dadcdd8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
现在的APP都注重用户的体验， 所以主流的APP都有无数据界面和无网络界面的显示来提醒用户。有一种简单的做法能实现上面那种需求，就是在每个控制器判断是否有网络，没有的话就加在无网络界面；但臃肿的代码显示不是我们这些程序猿的喜爱。
经过上网搜寻资料后， 理清了实现的基本思路：
** 1、给UIViewController添加类别（分类），添加无网络界面控件并成为无网络数据界面的代理方法和移除控件方法；
2、基于某网络请求框架封装的工具类中，传入目标控制器； 
3、网络请求时，在工具类中判断是否有网络，并实现相应的方法。**

###1、网络请求工具类
我是基于afnetworking框架写的工具类，主要是封装了签名认证和无网络返回block的处理，而加载无网络界面需要传入目标控制器。
         
       // 判断是否加载网络界面的普通的GET请求
     + (void)ZMG_Internet_general_getWithTarget:(nonnull UIViewController*)target  modelArr:(NSArray *)modelArr  url:(NSString *)url   params:(NSDictionary *)params   success:(void (^)(id json))success failure:(void (^)(NSError *error))failure connect:(void(^)(BOOL internet))IsAvailable; 
这个方法里target参数是目标控制器；
modelArr就是判断现在控制器所在的view有没有数据，有数据没有网络就弹出一个HUD,没数据没有网络的情况下，才像是无网络界面。
IsAvailable参数就是回调的block，yes为有网络，no为无网络；

    + (void)ZMG_Internet_general_getWithTarget:(nonnull UIViewController*)target  modelArr:(NSArray *)modelArr  url:(NSString *)url   params:(NSDictionary *)params   success:(void (^)(id json))success failure:(void (^)(NSError *error))failure connect:(void(^)(BOOL internet))IsAvailable{
    //1. 检测网络
    BOOL  intenet = [GlobalVariables isExistenceNetwork];
    if(IsAvailable){
        IsAvailable(intenet);
    }
    if(intenet == NO){// 没有网络
        if(modelArr.count>0)  return;// 如果已有数据，然后没有网络
        
        [target showNotInternetView];
        
    }else{  // 有网络
        // 打印请求的路径和参数
        [target hiddenNotInternetView];
        
        NSString* str = @"";
        for (NSString *key in params) {
            NSString* str2 = [[NSString alloc] initWithFormat:@"%@=%@&", key,params[key] ];
            str = [str stringByAppendingString:str2];
        }
        //  NSLog(@"%@?%@\n%@",url,str,params);
        
        // 2.创建请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
           mgr.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
        // 3.发送请求
        [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
 
    }
    

}

###2、 UIViewController+FDNotNetController分类

    - (void)showNotInternetView
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
    if([self isKindOfClass:[FDBaseTableViewController class]]){
        YY = 0;
    }
    
    FDNotInternetView  * view = [[FDNotInternetView alloc] initWithFrame:CGRectMake(0, YY, SYFWidth, SYFHeight-YY)];
    view.delegate = self;
    
    [self.view addSubview:view];
    }
    - (void)hiddenNotInternetView
    {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[FDNotInternetView class]]) {
            [view removeFromSuperview];
        }
    }
    }
      //无网络控件的代理方法
    - (void) reloadNetworkRequest:(id)sender
    {
    if ([self respondsToSelector:@selector(reloadRequest)]) {
        [self performSelector:@selector(reloadRequest)];
    }
    }

### 1、自定义无网络控件
    #import <UIKit/UIKit.h>
    @protocol FDNotInternetViewDelegate  <NSObject>
    - (void)reloadNetworkRequest:(id)sender;
    @end
    @interface FDNotInternetView : UIView
    /**
     *  由代理控制器去执行刷新网络
     */
    @property (nonatomic, weak) id<FDNotInternetViewDelegate>delegate;
    @end
在FDNotInternetView.m文件里，点击重新加载的实现方法：
      - (void)reloadNetworkDataSourcer:(id)sender {
     if (self.delegate && [self.delegate respondsToSelector:@selector(reloadNetworkRequest:)]) {
        [self.delegate performSelector:@selector(reloadNetworkRequest:) withObject:sender];
    }
}

** 最关键的一步： 
点击重新加载，要在控制器里面实现reloadRequest方法；
**
![](http://upload-images.jianshu.io/upload_images/1163208-51a4a3de2f296267.gif-syf?imageMogr2/auto-orient/strip)
