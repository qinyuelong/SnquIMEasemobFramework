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

@implementation SnquIMEasemobChatManager



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
            completion:(void (^)(NSString *message, NSError *error))aCompletionBlock{
    
    EMMessage *message = nil;
    [[EMClient sharedClient].chatManager sendMessage:message progress:aProgressBlock completion:^(EMMessage *message, EMError *error) {
        
    }];
    
}

@end
