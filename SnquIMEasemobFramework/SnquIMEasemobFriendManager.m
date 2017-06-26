//
//  SnquIMEasemobFriendManager.m
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobFriendManager.h"
#import <HyphenateLite/HyphenateLite.h>
#import "SnquIMEasemobUtils.h"

@interface SnquIMEasemobFriendManager()<EMContactManagerDelegate>

@end

@implementation SnquIMEasemobFriendManager

- (instancetype)init{
    self = [super init];
    if (self) {
        [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    }
    return self;
}

- (NSArray *)getContactsFromServer{
    EMError *error = nil;
    NSArray *userList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    return error ? nil :  userList;
}

- (void)getContactsFromServerWithCompletionBlock:(void (^)(NSArray *aList, NSError *error))completionBlock{
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(aList, error);
        }
    }];
}

- (NSArray *)getContactsFromLocalDatabase{
    NSArray *userList = [[EMClient sharedClient].contactManager getContacts];
    return userList;
}


#pragma mark - 好友申请

- (BOOL)addContact:(NSString *)contactId message:(NSString *)message{
    EMError *error = [[EMClient sharedClient].contactManager addContact:contactId message:message];
    return error == nil ;
}

- (void)addContact:(NSString *)contactId message:(NSString *)message completionBlock:(void (^)(NSString *userId, NSError *error))completionBlock{
    [[EMClient sharedClient].contactManager addContact:contactId message:message completion:^(NSString *userId, EMError *aError) {
        NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
        if (completionBlock) {
            completionBlock(userId, error);
        }
    }];
}


- (NSError *)acceptInvitationForUserId:(NSString *)userId{
    EMError *aError = [[EMClient sharedClient].contactManager acceptInvitationForUsername:userId];
    NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
    return error;
}

- (NSError *)declineInvitationForUserId:(NSString *)userId{
    EMError *aError = [[EMClient sharedClient].contactManager declineInvitationForUsername:userId];
    NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
    return error;
}


#pragma mark - 黑名单

- (NSArray *)getBlackListFromServerWithError:(NSError **)error{
    EMError *aError = nil;
    NSArray *blacklist = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&aError];
    NSError *resultError = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
    if (error && resultError) {
        *error = resultError;
        return nil;
    }
    return blacklist;
}

- (void)getBlackListFromServerWithCompletion:(void (^)(NSArray *aList, NSError *error))completionBlock{
    [[EMClient sharedClient].contactManager getBlackListFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(aList, error);
        }
    }];
}

- (NSArray *)getBlackListFromLocalDatabase{
    return  [[EMClient sharedClient].contactManager getBlackList];
}

- (NSError *)addUserToBlackList:(NSString *)userId{
    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:userId relationshipBoth:YES];
    return [SnquIMEasemobUtils convertEMErrorToNSError:error];
}

- (void)addUserToBlackList:(NSString *)userId completionBlock:(void(^)(NSString *userId, NSError *error)) completionBlock{
    [[EMClient sharedClient].contactManager addUserToBlackList:userId completion:^(NSString *userId, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(userId, error);
        }
    }];
}


- (NSError *)removeUserFromBlackList:(NSString *)userId{
    EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:userId];
    return [SnquIMEasemobUtils convertEMErrorToNSError:error];
}

- (void)removeUserFromBlackList:(NSString *)userId completionBlock:(void(^)(NSString *userId, NSError *error)) completionBlock{
    [[EMClient sharedClient].contactManager removeUserFromBlackList:userId completion:^(NSString *userId, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(userId, error);
        }
    }];
}

#pragma mark - EMContactManagerDelegate

- (void)friendRequestDidReceiveFromUser:(NSString *)userId message:(NSString *)aMessage{
    if (self.delegate) {
        [self.delegate friendRequestDidReceiveFromUser:userId message:aMessage];
    }
}

- (void)friendRequestDidApproveByUser:(NSString *)userId{
    if (self.delegate) {
        [self.delegate friendRequestDidApproveByUser:userId];
    }
}

- (void)friendRequestDidDeclineByUser:(NSString *)userId{
    if (self.delegate) {
        [self.delegate friendRequestDidDeclineByUser:userId];
    }
}


@end
