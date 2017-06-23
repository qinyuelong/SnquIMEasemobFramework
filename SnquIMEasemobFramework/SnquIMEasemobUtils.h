//
//  SnquIMEasemobUtils.h
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HyphenateLite/HyphenateLite.h>

@interface SnquIMEasemobUtils : NSObject

+ (NSError *)convertEMErrorToNSError:(EMError *)emError;

@end
