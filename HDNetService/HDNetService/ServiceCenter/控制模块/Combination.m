//
//  Combination.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "Combination.h"

#import "HDService.h"

@implementation DCData_Trunk
@end

@implementation DCData_TrunkParam
@end

@implementation DCDataCtrl_Trunk
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa1, 0x00, 0x19};
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    
    Byte engineOperateType = self.param.engineOperateType;
    Byte windowOperateType = self.param.windowOperateType;
    Byte doorOperateType = self.param.doorOperateType;
    Byte trunkOperateType = self.param.trunkOperateType;
    
    NSArray *param = @[[NSData dataWithBytes:&engineOperateType length:sizeof(engineOperateType)],
                       [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.engineDuration]],
                       [NSData dataWithBytes:&windowOperateType length:sizeof(windowOperateType)],
                       [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.windowDuration]],
                       [NSData dataWithBytes:&doorOperateType length:sizeof(doorOperateType)],
                       [NSData dataWithBytes:&trunkOperateType length:sizeof(trunkOperateType)],
                       ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:param srcID:[self.param.srcID dataUsingEncoding:NSUTF8StringEncoding] dstID:[self.param.dstID dataUsingEncoding:NSUTF8StringEncoding]];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end
