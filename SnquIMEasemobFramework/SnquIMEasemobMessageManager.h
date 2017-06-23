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

-(EMMessage *)convertMessageTextToEMMessage:(NSString *)messageText;


@end
