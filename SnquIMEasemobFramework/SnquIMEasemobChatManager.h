//
//  SnquIMEasemobChatManager.h
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobConversation.h"

@interface SnquIMEasemobChatManager : EMConversation

#pragma mark - 会话

/**
 获取会话 如果不存在将自动创建
 
 @param userId 会话ID
 @return 会话对象
 */
-(SnquIMEasemobConversation *)getConversationWithUser:(NSString *)userId;


/**
 获取所有的会话
 
 @return 会话集合
 */
-(NSArray *)getAllConversations;


/**
 获取某一个会话的未读消息数
 
 @param conversation 会话
 @return 未读消息数
 */
-(int)unReadMessageWithConversation:(SnquIMEasemobConversation *) conversation;

/**
 删除会话
 
 @param userId 会话 id
 @param delegateMessage 是否删除会话中的消息
 @param completionBlock 完成的回调
 */
-(void)deleteConversationWithUser:(NSString *)userId isDeleteMessage:(BOOL)delegateMessage completion:(void(^)(NSString *conversationId, NSError *error))completionBlock;



/**
 删除会话
 
 @param conversations 会话 ids 集合
 @param delegateMessage 是否删除会话中的消息
 @param completionBlock 完成的回调
 */
-(void)deleteConversations:(NSArray *)conversations isDeleteMessage:(BOOL)delegateMessage completion:(void(^)(NSError *error))completionBlock;

@end
