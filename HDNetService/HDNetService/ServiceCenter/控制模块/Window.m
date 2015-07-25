//
//  Window.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "Window.h"
#import "HDService.h"

@implementation DCData_Window
@end

@implementation DCData_WindowParam
@end

@implementation DCDataCtrl_Window
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa1, 0x00, 0x0c};
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    
    Byte operateType = self.param.operateType;
    
    NSArray *param = @[[NSData dataWithBytes:&operateType length:sizeof(operateType)],
                       [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.duration]]
                       ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:param srcID:[self.param.srcID dataUsingEncoding:NSUTF8StringEncoding] dstID:[self.param.dstID dataUsingEncoding:NSUTF8StringEncoding]];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:nil finsh:nil];
}

@end

