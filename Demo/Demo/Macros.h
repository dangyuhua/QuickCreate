//
//  Macros.h
//  Shopping
//
//  Created by 党玉华 on 2018/6/18.
//  Copyright © 2018年 党玉华. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


//高效率的NSLog
#ifdef DEBUG
#define DLog(...) NSLog(@"\n%s \n⚠️第%d行⚠️ \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...)
#endif


//NSError
#define ErrorMsg(text) [NSError errorWithDomain:NSCocoaErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:[NSDictionary dictionaryWithObject:text forKey:NSLocalizedDescriptionKey]]


//获取当前版本号
#define BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]


//GCD - 延迟执行
#define GCD_AFTER(time,afterBlock) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), afterBlock)
//GCD - 一次性执行
#define GCD_ONCE(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock)
//GCD - 异步主线程
#define GCD_MAIN_QUEUE_ASYNC(mainBlock) dispatch_async(dispatch_get_main_queue(), mainBlock)
//GCD - 异步子线程
#define GCD_GLOBAL_QUEUE_ASYNC(globalBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalBlock);


//获取window
#define WIN [UIApplication sharedApplication].delegate.window
//获取通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]
//NSUserDefaults
#define UserDefaults [NSUserDefaults standardUserDefaults]


//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//CGRectMake
#define Frame(x,y,w,h) CGRectMake(x, y, w, h)
//CGSizeMake
#define Size(w,h) CGSizeMake(w, h)
//UIEdgeInsetsMake
#define Edge(top,left,bottom,right)  UIEdgeInsetsMake(top, left, bottom, right)


//一像素
#define OnePixel 1/[UIScreen mainScreen].scale
//状态栏高度
#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
//Navigation高度
#define NaviBarHeight [UINavigationBar appearance].frame.size.height
//导航栏高度
#define TopBarHeight (Is_iPhoneX_Series ? 88.f : 64.f)
//标签栏高度
#define TabBarHeight (Is_iPhoneX_Series ? 83.f : 49.f)
/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width


//机型
#define Is_iPhoneXS_Max (ScreenW == 414.f && ScreenH == 896.f)
#define Is_iPhoneX (ScreenW == 375.f && ScreenH == 812.f)
#define Is_iPhone8_Plus (ScreenW == 414.f && ScreenH == 736.f)
#define Is_iPhone8 (ScreenW == 375.f && ScreenH == 667.f)
#define Is_iPhone5 (ScreenW == 320 && ScreenH == 568.f)
#define Is_iPhone5_OR_LESS (ScreenW == 320 && ScreenH <= 568.f)
#define Is_iPhoneX_Series (Is_iPhoneX||Is_iPhoneXS_Max)



#endif /* Macros_h */
