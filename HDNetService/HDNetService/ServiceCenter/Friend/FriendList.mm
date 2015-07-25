//
//  FriendList.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-24.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "FriendList.h"
#import "HDService.h"
using namespace iNetLib;

@implementation DCData_FriendListInfo

@end

@implementation DCData_FriendList

@end

@implementation DCData_FriendListParam

@end

@implementation DCDataCtrl_FriendList
{
    NSData *_cmdData;
}

- (void)dataRequest {
    Byte cmd[] = {0x00, 0xa2, 0x00, 0x0c}; //命令
    _cmdData = [NSData dataWithBytes:cmd length:sizeof(cmd)];
    NSArray *paramArray = @[[HDServiceWebSocket transform:self.param.user.token],
                            [HDServiceWebSocket transform:self.param.fkey],
                            [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.flag]],
                            [HDServiceWebSocket transform:[NSNumber numberWithInt:self.param.pageNumber]],
                            [HDServiceWebSocket transform:@20],
                            ];
    NSData *data = [HDServiceWebSocket packData:_cmdData paramArray:paramArray];
    [self webSocketRequest:data];
    
}

-(void)dataProcess:(NSData *)data {
    NSDictionary *propertyMap =
    @{@"dict":
          @{@"friends": @{@"name": @"friendArray",
                         @"class": [NSArray class],
                         @"elementclass":[DCData_FriendListInfo class],
                         }
            }};

    [HDServiceWebSocket evaluationCmdData:_cmdData retuData:data obj:self map:propertyMap finsh:nil];
}

- (void)demoData {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        DCData_FriendListInfo *info = [[DCData_FriendListInfo alloc] init];
        info.fid = i;
        info.nickname = info.username = [NSString stringWithFormat:@"%d", i];
        [array addObject:info];
    }
    
    self.data.friendArray = array;
    [self outputData];
}


@end


