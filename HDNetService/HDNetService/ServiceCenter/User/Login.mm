//
//  Login.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "Login.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_Login
@end

@implementation DCData_LoginParam
@end

@implementation DCDataCtrl_Login
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x02};
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    Byte aa[] = {0x01};
    NSData *aaData = [NSData dataWithBytes:aa length:sizeof(aa)];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:@[[HDServiceWebSocket transform:aaData], [HDServiceWebSocket transform:self.param.username] , [HDServiceWebSocket transform:self.param.password]]];
    [self webSocketRequest:data];

}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
