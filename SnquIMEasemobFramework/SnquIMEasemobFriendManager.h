//
//  SnquIMEasemobFriendManager.h
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - protocol
@protocol SnquIMEasemobFriendManagerDelegate <NSObject>

/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param userId   用户 id
 *  @param aMessage    附属信息
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)userId message:(NSString *)aMessage;


/**
 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调

 @param userId 用户B
 */
- (void)friendRequestDidApproveByUser:(NSString *)userId;


/**
 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调

 @param userId 用户B
 */
- (void)friendRequestDidDeclineByUser:(NSString *)userId;

@end


#pragma mark - class
@interface SnquIMEasemobFriendManager : NSObject

@property(nonatomic, weak) id<SnquIMEasemobFriendManagerDelegate> delegate;

#pragma mark - 获取好友

/**
 从服务器获取所有的好友 同步方法，会阻塞当前线程

 @return 好友 array 或者 nil
 */
- (NSArray *)getContactsFromServer;


/**
 从服务器获取所有的好友

 @param completionBlock 完成的回调
 */
- (void)getContactsFromServerWithCompletionBlock:(void (^)(NSArray *aList, NSError *error))completionBlock;


/**
  从本地数据库获取 好友

 @return 好友 array 或者 nil
 */
- (NSArray *)getContactsFromLocalDatabase;


#pragma mark - 好友申请


/**
 添加好友 同步方法，会阻塞当前线程

 @param contactId 用户 id
 @param message 附加消息
 @return 请求是否发生成功
 */
- (BOOL)addContact:(NSString *)contactId message:(NSString *)message;


/**
 添加好友

 @param contactId contactId 用户 id
 @param message 附加消息
 @param completionBlock 完成回调
 */
- (void)addContact:(NSString *)contactId message:(NSString *)message completionBlock:(void (^)(NSString *userId, NSError *error))completionBlock;



/**
 接受用户好友请求

 @param userId 请求者
 @return 错误信息
 */
- (NSError *)acceptInvitationForUserId:(NSString *)userId;


/**
 拒绝用户好友请求

 @param userId 请求者
 @return 错误信息
 */
- (NSError *)declineInvitationForUserId:(NSString *)userId;


#pragma mark - 黑名单


/**
 从服务器获取黑名单列表 同步方法，会阻塞当前线程

 @param error 错误信息
 @return 黑名单列表
 */
- (NSArray *)getBlackListFromServerWithError:(NSError **)error;


/**
 从服务器获取黑名单列表

 @param completionBlock 完成的回调
 */
- (void)getBlackListFromServerWithCompletion:(void (^)(NSArray *aList, NSError *error))completionBlock;


/**
  从本地获取黑名单列表

 @return 黑名单列表
 */
- (NSArray *)getBlackListFromLocalDatabase;



/**
 添加用户到黑名单 同步方法，会阻塞当前线程

 @param userId 用户b id
 @return 错误信息
 */
- (NSError *)addUserToBlackList:(NSString *)userId;


/**
 添加用户到黑名单

 @param userId 用户b id
 @param completionBlock 完成的回调
 */
- (void)addUserToBlackList:(NSString *)userId completionBlock:(void(^)(NSString *userId, NSError *error)) completionBlock;



/**
 将用户从黑名单中移除 同步方法，会阻塞当前线程

 @param userId 用户b id
 @return 错误信息
 */
- (NSError *)removeUserFromBlackList:(NSString *)userId;


/**
 将用户从黑名单中移除

 @param userId 用户b id
 @param completionBlock 完成的回调
 */
- (void)removeUserFromBlackList:(NSString *)userId completionBlock:(void(^)(NSString *userId, NSError *error)) completionBlock;
@end
