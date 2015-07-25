//
//  AddrAdd.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-24.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "AddrAdd.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_AddrAdd

@end

@implementation DCData_AddrAddParam

@end

@implementation DCDataCtrl_AddrAdd
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x0e}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:[NSString stringWithFormat:@"%f:/%f:/%@",self.param.latitude,self.param.longitude,self.param.addr]],
                            [HDServiceWebSocket transform:self.param.addrNote],
                            [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.addrFlag]],
                            [HDServiceWebSocket transform:self.param.fid],
                            [HDServiceWebSocket transform:self.param.shareTime == 0 ? nil : [NSNumber numberWithLongLong:self.param.shareTime]],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
