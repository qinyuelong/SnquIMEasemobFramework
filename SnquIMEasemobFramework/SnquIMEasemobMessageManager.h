//
//  SnquIMEasemobMessageManager.h
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HyphenateLite/HyphenateLite.h>

@interface SnquIMEasemobMessageManager : NSObject


/**
 用户 b id
 */
@property (nonatomic, strong) NSString *conversationId;

-(instancetype)initWithConversationId:(NSString *)conversationId;

-(EMMessage *)convertMessageTextToEMMessage:(NSString *)messageText;

-(EMMessage *)convertImageMessageToEMMessage:(NSData *)imageData displayName:(NSString *)displayName;


@end
