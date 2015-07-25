//
//  CarList.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-7-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "CarList.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_CarList

@end

@implementation DCData_CarListInfo

@end

@implementation DCData_CarListParam

@end

@implementation DCDataCtrl_CarList
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa1, 0x00, 0x51};
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:nil];
    [self webSocketRequest:data];
}

-(void)dataProcess:(NSData *)data {
    NSDictionary *map = @{@"dict":
                             @{@"keys": @{@"name": @"carListArray",
                                        @"class": [NSArray class],
                                        @"elementclass":[DCData_CarListInfo class],
                          }
            }};

    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:map finsh:nil];
    
}

@end
