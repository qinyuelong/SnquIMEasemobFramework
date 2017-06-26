//
//  SnquIMEasemobChatManager.m
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobChatManager.h"
#import <HyphenateLite/HyphenateLite.h>
#import "SnquIMEasemobUtils.h"
#import "SnquIMEasemobMessageManager.h"


@interface  SnquIMEasemobChatManager()<EMChatManagerDelegate>
@property (nonatomic, strong) SnquIMEasemobMessageManager *messageManager;

@end


@implementation SnquIMEasemobChatManager


-(instancetype)initWithConversationId:(NSString *)conversationId{
    self = [super init];
    if (self) {
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        [self getConversationWithUser:conversationId];
        self.messageManager = [[SnquIMEasemobMessageManager alloc] initWithConversationId:conversationId];
    }
    return self;
}



-(void)removeDelegate{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

-(SnquIMEasemobConversation *)getConversationWithUser:(NSString *)userId{
    SnquIMEasemobConversation  *converstation = (SnquIMEasemobConversation *)[[EMClient sharedClient].chatManager getConversation:userId type:EMConversationTypeChat createIfNotExist:YES];
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

-(int)unReadMessageWithConversation:(SnquIMEasemobConversation *) conversation{
    return [conversation unreadMessagesCount];
}



-(void)sendTextMessage:(NSString *)messageText progress:(void (^)(int progress))aProgressBlock
            completion:(void (^)(SnquIMEasemobMessage *message, NSError *error))completionBlock{
    
    EMMessage *message = [self.messageManager convertMessageTextToEMMessage:messageText];
    [[EMClient sharedClient].chatManager sendMessage:message progress:aProgressBlock completion:^(EMMessage *message, EMError *error) {
        if (completionBlock) {
            NSError *e = [SnquIMEasemobUtils convertEMErrorToNSError:error];
            completionBlock((SnquIMEasemobMessage *)message, e);
        }
    }];
}

-(void)sendImageMessage:(NSData *)imageData imageName:(NSString *)imageName progress:(void (^)(int progress))aProgressBlock
             completion:(void (^)(SnquIMEasemobMessage *message, NSError *error))completionBlock{
    EMMessage *message = [self.messageManager convertImageMessageToEMMessage:imageData displayName:imageName];
    [[EMClient sharedClient].chatManager sendMessage:message progress:aProgressBlock completion:^(EMMessage *message, EMError *error) {
        if (completionBlock) {
            NSError *e = [SnquIMEasemobUtils convertEMErrorToNSError:error];
            completionBlock((SnquIMEasemobMessage *)message, e);
        }
    }];
}

-(void)sendMessageReadAck:(SnquIMEasemobMessage *)message completion:(void (^)(SnquIMEasemobMessage *message, NSError *error))completionBlock{
    [[EMClient sharedClient].chatManager sendMessageReadAck:message completion:^(EMMessage *aMessage, EMError *aError) {
        if (completionBlock) {
            NSError *error = [SnquIMEasemobUtils convertEMErrorToNSError:aError];
            completionBlock((SnquIMEasemobMessage *)aMessage, error);
        }
    }];
}

#pragma mark - EMChatManagerDelegate


// 在线普通消息会走以下回调：


- (void)messagesDidReceive:(NSArray<SnquIMEasemobMessage *> *)aMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messagesDidReceive:)]) {
        [self.delegate messagesDidReceive:aMessages];
    }
}

// 透传(cmd)在线消息会走以下回调:


- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cmdMessagesDidReceive:)]) {
        [self.delegate cmdMessagesDidReceive:aCmdMessages];
    }
}

// 消息已送达回执
-(void)messagesDidDeliver:(NSArray<SnquIMEasemobMessage *> *)aMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cmdMessagesDidReceive:)]) {
        [self.delegate messagesDidDeliver:aMessages];
    }
}

// 接收已读回执
-(void)messagesDidRead:(NSArray<SnquIMEasemobMessage *> *)aMessages{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messagesDidRead:)]) {
        [self.delegate messagesDidRead:aMessages];
    }
}


@end
