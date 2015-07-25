//
//  HDNetRequest.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDNetRequest.h"
#import "Debug.h"

@implementation HDNetRequest

-(void)requestCompleted:(NSError*)error
{
    [_delegate netRequestCompletion:self error:error];
}

-(NSData *)responseData
{
    return nil;
}

-(bool)isInProgress
{
    IN_ASSERT(0);	//需要子类实现
    return false;
}

-(bool)start
{
    IN_ASSERT(0);	//需要子类实现
    return false;
}

-(void)cancel
{
    IN_ASSERT(0);	//需要子类实现
}


@end
