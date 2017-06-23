//
//  SnquIMEasemobManager.m
//  SnquIMFramework
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//  http://docs.easemob.com/im/300iosclientintegration/30iossdkbasic

#import "SnquIMEasemobManager.h"
#import <HyphenateLite/HyphenateLite.h>

@interface SnquIMEasemobManager()

@property (nonatomic, strong) NSString *appkey;
@property (nonatomic, strong) NSString *apnsCertName;

@end

@implementation SnquIMEasemobManager

+ (instancetype)defaultInstance{
    static SnquIMEasemobManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SnquIMEasemobManager alloc] init];
    });
    return instance;
}

#pragma mark - LiftCycle

- (void)initializeSDKWithAppkey:(NSString *)appkey apnsCerName:(NSString *)apnsCerName{
    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
    options.apnsCertName = apnsCerName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


@end
