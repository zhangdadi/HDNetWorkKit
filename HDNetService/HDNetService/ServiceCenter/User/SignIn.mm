//
//  SignIn.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "SignIn.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_SignIn

@end

@implementation DCData_SignInParam

@end

@implementation DCDataCtrl_SignIn
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x01};
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.username],
                            [HDServiceWebSocket transform:self.param.password],
                            [HDServiceWebSocket transform:self.param.nickname],
                            [HDServiceWebSocket transform:self.param.email],
                            [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.sex]],
                            [HDServiceWebSocket transform:self.param.tel],
    ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
}

-(void)dataProcess:(NSData *)data {
     [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];

}
@end
