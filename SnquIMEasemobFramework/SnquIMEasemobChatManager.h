//
//  SnquIMEasemobChatManager.h
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobConversation.h"
#import "SnquIMEasemobMessage.h"

@protocol SnquIMEasemobChatManagerDelegate <NSObject>


/**
 收到消息

 @param aMessages 消息数组
 
 @code
 // 解析消息
 for (SnquIMEasemobMessage *message in aMessages) {
    EMMessageBody *msgBody = message.body;
    switch (msgBody.type) {
         case EMMessageBodyTypeText:{
             // 收到的文字消息
             EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
             NSString *txt = textBody.text;
             NSLog(@"收到的文字是 txt -- %@",txt);
         }
         break;
 
         case EMMessageBodyTypeImage: {
             // 得到一个图片消息body
             EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
             NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
             NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
             NSLog(@"大图的secret -- %@"    ,body.secretKey);
             NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
             NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
             
             
             // 缩略图sdk会自动下载
             NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
             NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
             NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
             NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
             NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
         }
         break;
 
         default:
         break;
 
 
    }
 }
 
 @endcode
 
 */
- (void)snquIMEasemobMessagesDidReceive:(NSArray<SnquIMEasemobMessage *> *)aMessages;

// 透传(cmd)在线消息会走以下回调:
/*!
 @method
 @brief 接收到一条及以上cmd消息
 */
- (void)snquIMEasemobCmdMessagesDidReceive:(NSArray *)aCmdMessages;

// 消息已送达回执
-(void)snquIMEasemobMessagesDidDeliver:(NSArray<SnquIMEasemobMessage *> *)aMessages;

// 接收已读回执
-(void)snquIMEasemobMessagesDidRead:(NSArray<SnquIMEasemobMessage *> *)aMessages;

@end





@interface SnquIMEasemobChatManager : EMConversation

@property (nonatomic, weak) id<SnquIMEasemobChatManagerDelegate> delegate;


/**
 初始化并自动 注册消息回调
 
 @param conversationId 用户 B id
 @return instance
 */
-(instancetype)initWithConversationId:(NSString *)conversationId;

/**
 //移除消息回调
 */
-(void)removeDelegate;


#pragma mark - 会话

/**
 获取会话 如果不存在将自动创建
 
 @param userId 用户 b userId
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


#pragma mark -  消息


/**
 发送文本消息

 @param messageText 消息内容
 @param aProgressBlock progress block
 @param completionBlock 完成的回调
 */
-(void)sendTextMessage:(NSString *)messageText progress:(void (^)(int progress))aProgressBlock
            completion:(void (^)(SnquIMEasemobMessage *message, NSError *error))completionBlock;



/**
 发送图片消息

 @param imageData 图片数据
 @param imageName 图片名称
 @param aProgressBlock progress block
 @param completionBlock 完成的回调
 */
-(void)sendImageMessage:(NSData *)imageData imageName:(NSString *)imageName progress:(void (^)(int progress))aProgressBlock
            completion:(void (^)(SnquIMEasemobMessage *message, NSError *error))completionBlock;

/**
 发送消息已读回执

 @param message 消息对象
 @param completionBlock 完成的回调
 */
-(void)sendMessageReadAck:(SnquIMEasemobMessage *)message completion:(void (^)(SnquIMEasemobMessage *message, NSError *error))completionBlock;


@end
