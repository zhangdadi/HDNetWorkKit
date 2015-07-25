//
//  PublicAdd.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "PublicAdd.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_PublicAdd

@end

@implementation DCData_PublicAddParam

@end

@implementation DCDataCtrl_PublicAdd
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x17}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:[NSNumber numberWithLong:self.param.pid]],
                            [HDServiceWebSocket transform:[NSNumber numberWithLong:self.param.cid]],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end