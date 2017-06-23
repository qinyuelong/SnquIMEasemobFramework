//
//  SnquIMEasemobLoginManager.h
//  SnquIMFramework
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SnquIMConnectionConnected = 0,  /*! *\~chinese 已连接 *\~english Connected */
    SnquIMConnectionDisconnected,   /*! *\~chinese 未连接 *\~english Not connected */
} SnquIMConnectionState;

@protocol SnquIMEasemobLoginManagerDelegate <NSObject>


/**
    当掉线时， SDK 会自动重连，只需要监听重连相关的回调，无需进行任何操作
 */
-(void)connectionStateDidChange:(SnquIMConnectionState)connectionState;



/**
    当前登录账号在其它设备登录时会接收到该回调
 */
- (void)accountDidLoginFromOtherDevice;



/**
    当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)accountDidRemoveFromServer;


@end



@interface SnquIMEasemobLoginManager : NSObject

@property (nonatomic, weak) id<SnquIMEasemobLoginManagerDelegate> delegate;

+ (instancetype)defaultInstance;


/**
 同步方法，会阻塞当前线程

 @param userId 用户 id
 @param password 密码
 @return 是否登录成功
 */
- (BOOL)loginWithUserId:(NSString *)userId password:(NSString *)password;


/**
 密码登录 异步方法，不会阻塞当前线程

 @param userId 用户 id
 @param password 密码
 @param completionBlock 登录完成 block
 */
- (void)loginWithUserId:(NSString *)userId password:(NSString *)password completion:(void (^)(NSString *userId, NSError *error)) completionBlock;



/**
 登录，不支持自动登录 同步方法，会阻塞当前线程

 @param userId 用户 id
 @param token token
 @return 是否登录成功
 */
- (BOOL)loginWithUserId:(NSString *)userId token:(NSString *)token;



/**
 异步方法，不会阻塞当前线程 登录，不支持自动登录

 @param userId 用户名
 @param token token
 @param completionBlock 登录完成 block
 */
- (void)loginWithUserId:(NSString *)userId token:(NSString *)token completion:(void (^)(NSString *userId, NSError *error)) completionBlock;


/**
 设置以后是否自动登录  注意: 需要在登录成功后设置

 @param autoLogin auto login
 */
- (void)setIsAutoLogin:(BOOL)autoLogin;





/**
 主动退出登录

 @param unbindDeviceToken 是否解除device token的绑定，解除绑定后设备不会再收到消息推送 如果传入YES, 解除绑定失败，将返回error
 @return 返回error or nil
 */
- (NSError *)logoutWithUnbindDeviceToken:(BOOL)unbindDeviceToken;


/**
 主动退出登录

 @param unbindDeviceToken 是否解除device token的绑定，解除绑定后设备不会再收到消息推送 如果传入YES, 解除绑定失败，将返回error
 @param completionBlock 完成的回调
 */
- (void)logout:(BOOL)unbindDeviceToken completion:(void (^)(NSError *error))completionBlock;

@end
