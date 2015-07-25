//
//  LogOut.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "LogOut.h"
#import "HDService.h"


@implementation DCData_LogOut

@end

@implementation DCData_LogOutParam

@end

@implementation DCDataCtrl_LogOut
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x03}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:@[[HDServiceWebSocket transform:self.param.user.token]]];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}


@end

