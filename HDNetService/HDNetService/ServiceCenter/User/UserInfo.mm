//
//  UserInfo.m
//  yDriveData
//
//  Created by 张达棣 on 14-6-20.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "HDService.h"
#import "UserInfo.h"



@implementation DCData_UserInfo

@end

@implementation DCData_UserInfoParam

@end

@implementation DCDataCtrl_UserInfo
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x04}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:@[[HDServiceWebSocket transform:self.param.user.token]]];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
