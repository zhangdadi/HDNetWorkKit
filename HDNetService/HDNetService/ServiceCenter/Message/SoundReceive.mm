//
//  SoundReceive.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-15.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "SoundReceive.h"
#import "HDService.h"
using namespace iNetLib;


@implementation DCData_SoundReceiveObj

@end

@implementation DCData_SoundReceiveParam

@end

@implementation DCDataCtrl_SoundReceive

- (void)dataRequest {
    [self outputData];
}

- (void)dataProcess:(NSData *)data {
    
}
@end