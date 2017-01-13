### 1、给UIViewController添加类别（分类），添加无网络界面控件并成为无网络数据界面的代理方法和移除控件方法；
### 2、基于某网络请求框架封装的工具类中，传入目标控制器； 
### 3、网络请求时，在工具类中判断是否有网络，并实现相应的方法。
![](http://upload-images.jianshu.io/upload_images/1163208-50bd43907dadcdd8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
实例
------
![](http://upload-images.jianshu.io/upload_images/1163208-51a4a3de2f296267.gif-syf?imageMogr2/auto-orient/strip)
# 最关键的一步： 点击重新加载，要在控制器里面实现reloadRequest方法；
