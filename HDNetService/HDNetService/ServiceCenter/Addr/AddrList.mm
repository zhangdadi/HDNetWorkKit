//
//  AddrList.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "AddrList.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_ShareListInfo

@end

@implementation DCData_FavListInfo

@end

@implementation DCData_AddrList

@end

@implementation DCData_AddrListParam

@end

@implementation DCDataCtrl_AddrList
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x11}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:[NSNumber numberWithLong:self.param.fid]],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    NSDictionary *propertyMap =
    @{
      @"dict":
          @{@"shareAddr": @{@"name": @"shareAddr",
                            @"class": [NSArray class],
                            @"elementclass":[DCData_ShareListInfo class],
                            },
            @"favAddr": @{@"name": @"favAddr",
                          @"class": [NSArray class],
                          @"elementclass":[DCData_FavListInfo class],
                          }
            }
      };
    
    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:propertyMap finsh:^{
        DCData_AddrList *obj = self.data;
        if (obj.shareAddr.count != 0) {
            for (int i = 0; i < obj.shareAddr.count; i++) {
                NSString * string = ((DCData_ShareListInfo *)(obj.shareAddr[i])).addrContent;
                NSArray *array = [string componentsSeparatedByString:@":/"];
                if (array.count >= 3) {
                    float latitude = [[array objectAtIndex:0] floatValue];
                    float longitude = [[array objectAtIndex:1] floatValue];
                    NSString *address = [array objectAtIndex:2];
                    ((DCData_ShareListInfo *)(obj.shareAddr[i])).latitude = latitude;
                    ((DCData_ShareListInfo *)(obj.shareAddr[i])).longitude = longitude;
                    ((DCData_ShareListInfo *)(obj.shareAddr[i])).addrContent = address;
                }
            }
        }
        if (obj.favAddr.count != 0) {
            for (int i = 0; i < obj.favAddr.count; i++) {
                NSString * string = ((DCData_FavListInfo *)(obj.favAddr[i])).addrContent;
                NSArray *array = [string componentsSeparatedByString:@":/"];
                if (array.count >= 3) {
                    float latitude = [[array objectAtIndex:0] floatValue];
                    float longitude = [[array objectAtIndex:1] floatValue];
                    NSString *address = [array objectAtIndex:2];
                    ((DCData_FavListInfo *)(obj.favAddr[i])).latitude = latitude;
                    ((DCData_FavListInfo *)(obj.favAddr[i])).longitude = longitude;
                    ((DCData_FavListInfo *)(obj.favAddr[i])).addrContent = address;
                }
            }
        }
    }];
}
@end

