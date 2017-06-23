//
//  SnquIMEasemobMessageManager.m
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobMessageManager.h"

@implementation SnquIMEasemobMessageManager

-(EMMessage *)convertMessageTextToEMMessage:(NSString *)messageText{
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:messageText];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成 message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:nil from:from to:nil body:body ext:nil];
    message.chatType = EMChatTypeChat;
    return message;
}


@end
