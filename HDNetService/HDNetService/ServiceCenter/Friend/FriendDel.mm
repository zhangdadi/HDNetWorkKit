//
//  FriendDel.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "FriendDel.h"
#import "HDService.h"
using namespace iNetLib;

@implementation DCData_FriendDel

@end

@implementation DCData_FriendDelParam

@end

@implementation DCDataCtrl_FriendDel
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x0b}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:[NSNumber numberWithInteger:self.param.fid]],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
