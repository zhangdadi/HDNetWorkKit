//
//  ModifyUserInfo.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "ModifyUserInfo.h"
#import "HDService.h"


@implementation DCData_ModifyUserInfo

@end

@implementation DCData_ModifyUserInfoParam

@end

@implementation DCDataCtrl_ModifyUserInfo
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x05}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSString *iconName = @"icon.png";
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:self.param.nickname],
                            [HDServiceWebSocket transform:self.param.email],
                            [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.sex]],
                            [HDServiceWebSocket transform:iconName],
                            [HDServiceWebSocket transform:self.param.icon],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
