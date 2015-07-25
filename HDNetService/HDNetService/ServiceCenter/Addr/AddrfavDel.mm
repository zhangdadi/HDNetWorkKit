//
//  AddrfavDel.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "AddrfavDel.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_AddrfavDel

@end

@implementation DCData_AddrfavDelParam

@end

@implementation DCDataCtrl_AddrfaveDel
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x10}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:[NSNumber numberWithLong:self.param.addrId]],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end

