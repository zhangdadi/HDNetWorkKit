//
//  TokenLogin.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-10.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "TokenLogin.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_LoginToken
@end

@implementation DCData_LoginTokenParam
@end

@implementation DCDataCtrl_LoginToken
{
    NSData *_cmdData;
}

- (void)dataRequest {
    if (self.param.user.token == nil) {
        [self outputData];
    }
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x02};
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    Byte aa[] = {0x02};
    NSData *aaData = [NSData dataWithBytes:aa length:sizeof(aa)];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:@[aaData, [self.param.user.token dataUsingEncoding:NSUTF8StringEncoding]]];
    [self webSocketRequest:data];
}

-(void)dataProcess:(NSData *)data {
     [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end

