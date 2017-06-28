//
//  SnquIMEasemobChatManager.m
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobChatManager.h"
#import "SnquIMEasemobUtils.h"
#import "SnquIMEasemobMessageManager.h"


@interface  SnquIMEasemobChatManager()<EMChatManagerDelegate>
@property (nonatomic, strong) SnquIMEasemobMessageManager *messageManager;

@end


@implementation SnquIMEasemobChatManager

+(instancetype)defaultInstance{
    static SnquIMEasemobChatManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SnquIMEasemobChatManager alloc] init];
        [[EMClient sharedClient].chatManager addDelegate:instance delegateQueue:nil];
    });
    return instance;
}

-(instancetype)initWithConversationId:(NSString *)conversationId{
    self = [super init];
    if (self) {
        
        [self getConversationWithUser:conversationId];
        self.messageManager = [[SnquIMEasemobMessageManager alloc] initWithConversationId:conversationId];
    }
    return self;
}


-(void)removeDelegate{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

-(EMConversation *)getConversationWithUser:(NSString *)userId{
    EMConversation  *converstation = [[EMClient sharedClient].chatManager getConversation:userId type:EMConversationTypeChat createIfNotExist:YES];
    [converstation unreadMessagesCount];
    return converstation;
}

-(void)deleteConversationWithUser:(NSString *)userId isDeleteMessage:(BOOL)delegateMessage completion:(void(^)(NSString *conversationId, NSError *error))completionBlock{
    
    [[EMClient sharedClient].chatManager deleteConversation:userId isDeleteMessages:delegateMessage completion:^(NSString *aConversationId, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(aConversationId, error);
        }
    }];
}

-(void)deleteConversations:(NSArray *)conversations isDeleteMessage:(BOOL)delegateMessage completion:(void(^)(NSError *error))completionBlock{
    
    [[EMClient sharedClient].chatManager deleteConversations:conversations isDeleteMessages:delegateMessage completion:^(EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(error);
        }
    }];
}

-(NSArray *)getAllConversations{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    return conversations;
}

-(int)unReadMessageWithConversation:(EMConversation *) conversation{
    return [conversation unreadMessagesCount];
}



-(void)sendTextMessage:(NSString *)messageText progress:(void (^)(int progress))aProgressBlock
            completion:(void (^)(EMMessage *message, NSError *error))completionBlock{
    
    EMMessage *message = [self.messageManager convertMessageTextToEMMessage:messageText];
    [[EMClient sharedClient].chatManager sendMessage:message progress:aProgressBlock completion:^(EMMessage *message, EMError *error) {
        if (completionBlock) {
            NSError *e = [SnquIMEasemobUtils convertEMErrorToNSError:error];
            completionBlock(message, e);
        }
    }];
}

-(void)sendImageMessage:(NSData *)imageData imageName:(NSString *)imageName progress:(void (^)(int progress))aProgressBlock
             completion:(void (^)(EMMessage *message, NSError *error))completionBlock{
    EMMessage *message = [self.messageManager convertImageMessageToEMMessage:imageData displayName:imageName];
    [[EMClient sharedClient].chatManager sendMessage:message progress:aProgressBlock completion:^(EMMessage *message, EMError *error) {
        if (completionBlock) {
            NSError *e = [SnquIMEasemobUtils convertEMErrorToNSError:error];
            completionBlock(message, e);
        }
    }];
}

-(void)sendMessageReadAck:(EMMessage *)message completion:(void (^)(EMMessage *message, NSError *error))completionBlock{
    [[EMClient sharedClient].chatManager sendMessageReadAck:message completion:^(EMMessage *aMessage, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock(aMessage, error);
        }
    }];
}

#pragma mark - EMChatManagerDelegate


// 在线普通消息会走以下回调：

- (void)conversationListDidUpdate:(NSArray *)aConversationList{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snquIMeasemobConversationListDidUpdate:)]) {
        [self.delegate snquIMeasemobConversationListDidUpdate:aConversationList];
    }
}


- (void)messagesDidReceive:(NSArray<EMMessage *> *)aMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snquIMEasemobMessagesDidReceive:)]) {
        [self.delegate snquIMEasemobMessagesDidReceive:aMessages];
    }
}

// 透传(cmd)在线消息会走以下回调:


- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snquIMEasemobCmdMessagesDidReceive:)]) {
        [self.delegate snquIMEasemobCmdMessagesDidReceive:aCmdMessages];
    }
}

// 消息已送达回执
-(void)messagesDidDeliver:(NSArray<EMMessage *> *)aMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snquIMEasemobMessagesDidDeliver:)]) {
        [self.delegate snquIMEasemobMessagesDidDeliver:aMessages];
    }
}

// 接收已读回执
-(void)messagesDidRead:(NSArray<EMMessage *> *)aMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snquIMEasemobMessagesDidRead:)]) {
        [self.delegate snquIMEasemobMessagesDidRead:aMessages];
    }
}


@end
