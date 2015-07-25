//
//  AddrshareDel.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "AddrshareDel.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_AddrshareDel

@end

@implementation DCData_AddrshareDelParam

@end

@implementation DCDataCtrl_AddrShareDel
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x0f}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:[NSNumber numberWithLong:self.param.addrId]],
                            [HDServiceWebSocket transform:self.param.fid],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
