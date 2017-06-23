//
//  SnquIMEasemobLoginManager.m
//  SnquIMFramework
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobLoginManager.h"
#import <HyphenateLite/HyphenateLite.h>

@interface SnquIMEasemobLoginManager()<EMClientDelegate>

@end

@implementation SnquIMEasemobLoginManager

+ (instancetype)defaultInstance{
    static SnquIMEasemobLoginManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SnquIMEasemobLoginManager alloc] init];
        [[EMClient sharedClient] addDelegate:instance delegateQueue:nil];
    });
    return instance;
}

- (BOOL)loginWithUserId:(NSString *)userId password:(NSString *)password {
    EMError *error = [[EMClient sharedClient] loginWithUsername:userId password:password];
    if (!error) {
        return YES;
    }
    return NO;
}


- (void)loginWithUserId:(NSString *)userId password:(NSString *)password completion:(void (^)(NSString *userId, NSError *error)) completionBlock {
    
    [[EMClient sharedClient] loginWithUsername:userId password:password completion:^(NSString *userId, EMError *aError) {
        if (completionBlock) {
            NSError *error = nil;
            if (aError) {
                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey : aError.errorDescription};
                error = [NSError errorWithDomain:@"SnquIMFrameError" code:aError.code userInfo:userInfo];
            }
            completionBlock(userId, error);
        }
    }];
}


- (BOOL)loginWithUserId:(NSString *)userId token:(NSString *)token {
    EMError *error = [[EMClient sharedClient] loginWithUsername:userId token:token];
    if (!error) {
        return YES;
    }
    return NO;
}

- (void)loginWithUserId:(NSString *)userId token:(NSString *)token completion:(void (^)(NSString *userId, NSError *error)) completionBlock {
    
    [[EMClient sharedClient] loginWithUsername:userId token:token completion:^(NSString *userId, EMError *aError) {
        if (completionBlock) {
            NSError *error = nil;
            if (aError) {
                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey : aError.errorDescription};
                error = [NSError errorWithDomain:@"SnquIMFrameError" code:aError.code userInfo:userInfo];
            }
            completionBlock(userId, error);
        }
    }];
}

- (void)setIsAutoLogin:(BOOL)autoLogin{
    [[EMClient sharedClient].options setIsAutoLogin:autoLogin];
}

- (NSError *)logoutWithUnbindDeviceToken:(BOOL)unbindDeviceToken{
    EMError *aError = [[EMClient sharedClient] logout:unbindDeviceToken];
    NSError *e = nil;
    if (aError) {
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey : aError.errorDescription};
        e = [NSError errorWithDomain:@"SnquIMFrameError" code:aError.code userInfo:userInfo];
    }
    return e;
}

- (void)logout:(BOOL)unbindDeviceToken completion:(void (^)(NSError *error))completionBlock{
    [[EMClient sharedClient] logout:unbindDeviceToken completion:^(EMError *aError) {
        if (completionBlock) {
            NSError *error = nil;
            if (aError) {
                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey : aError.errorDescription};
                error = [NSError errorWithDomain:@"SnquIMFrameError" code:aError.code userInfo:userInfo];
            }
            completionBlock(error);
        }
    }];
}

#pragma mark - EMClientDelegate

- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    if (self.delegate) {
        if (aConnectionState == EMConnectionConnected) {
            [self.delegate connectionStateDidChange:SnquIMConnectionConnected];
        }else if (aConnectionState == EMConnectionDisconnected){
            [self.delegate connectionStateDidChange:SnquIMConnectionDisconnected];
        }
    }
}


- (void)userAccountDidLoginFromOtherDevice{
    if (self.delegate) {
        [self.delegate accountDidLoginFromOtherDevice];
    }
}

- (void)userAccountDidRemoveFromServer{
    if (self.delegate) {
        [self.delegate accountDidRemoveFromServer];
    }
}

@end
