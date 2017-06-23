//
//  SnquIMEasemobUtils.m
//  SnquIMEasemobFramework
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SnquIMEasemobUtils.h"


@implementation SnquIMEasemobUtils

+ (NSError *)convertEMErrorToNSError:(EMError *)emError{
    NSError *error = nil;
    if (emError) {
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey : emError.errorDescription};
        error = [NSError errorWithDomain:@"SnquIMFrameError" code:emError.code userInfo:userInfo];
    }
    return error;
}

@end
