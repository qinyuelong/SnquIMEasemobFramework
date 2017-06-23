//
//  SnquIMEasemobManager.h
//  SnquIMFramework
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SnquIMEasemobManager : NSObject

+ (instancetype)defaultInstance;


/**
 在工程的 AppDelegate 中的 didFinishLaunchingWithOptions方法中，调用

 @param appkey 注册的AppKey
 @param apnsCerName 推送证书名（不需要加后缀）
 */
- (void)initializeSDKWithAppkey:(NSString *)appkey apnsCerName:(NSString *)apnsCerName;


/**
 在工程的 AppDelegate 中的 applicationDidEnterBackground方法中，调用

 @param application application
 */
- (void)applicationDidEnterBackground:(UIApplication *)application;



/**
 在工程的 AppDelegate 中的 applicationWillEnterForeground方法中，调用

 @param application application
 */
- (void)applicationWillEnterForeground:(UIApplication *)application;

@end
