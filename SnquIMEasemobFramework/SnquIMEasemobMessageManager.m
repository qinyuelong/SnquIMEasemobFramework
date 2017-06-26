//
//  SnquIMEasemobMessageManager.m
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobMessageManager.h"

@implementation SnquIMEasemobMessageManager

-(instancetype)initWithConversationId:(NSString *)conversationId{
    self = [super init];
    if (self) {
        self.conversationId = conversationId;
    }
    return self;
}

-(EMMessage *)convertMessageTextToEMMessage:(NSString *)messageText{
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:messageText];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成 message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversationId from:from to:self.conversationId body:body ext:nil];
    message.chatType = EMChatTypeChat;
    return message;
}

-(EMMessage *)convertImageMessageToEMMessage:(NSData *)imageData displayName:(NSString *)displayName{
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:imageData displayName:displayName];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成 message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversationId from:from to:self.conversationId body:body ext:nil];
    message.chatType = EMChatTypeChat;
    return message;
}

@end
