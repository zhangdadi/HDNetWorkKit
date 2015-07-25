//
//  CarMessageReceive.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-12.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "CarMessageReceive.h"
#import "HDService.h"

using namespace iNetLib;


@implementation DCData_CarMessageListInfo

@end

@implementation DCData_CarMessageList

@end

@implementation DCData_CarMessageReceiveParam

@end

@implementation DCDataCtrl_CarMessageReceive

- (void)dataRequest {
    if (self.param.user.token == nil) {
        return;
    }
    [self outputData];
}

- (void)dataProcess:(NSData *)data {
    
}

@end

