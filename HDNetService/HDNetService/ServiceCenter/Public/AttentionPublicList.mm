//
//  AttentionPublicList.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "AttentionPublicList.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_AttentionPublicListInfo

@end

@implementation DCData_AttentionPublicList

@end

@implementation DCData_AttentionPublicListParam

@end

@implementation DCDataCtrl_AttentionPublicList
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x14}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:self.param.fkey],
                            [HDServiceWebSocket transform:[NSNumber numberWithLong:self.param.pid]],
                            ];

    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end

