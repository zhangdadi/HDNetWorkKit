//
//  SendPublicNoMessage.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-19.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "SendPublicNoMessage.h"
#import "HDService.h"
using namespace iNetLib;

@implementation DCData_SendPublicNoMessageObj

@end

@implementation DCData_SendPublicNoMessageParam
- (void)setMsgContent:(NSString *)msgContent {
    if (_msgContent != msgContent) {
        _msgContent = msgContent;
        _msgSound = nil;
        _msgImage = nil;
    }
}

- (void)setMsgSound:(NSData *)msgSound {
    if (_msgSound != msgSound) {
        _msgSound = msgSound;
        _msgContent = nil;
        _msgImage = nil;
    }
}

- (void)setMsgImage:(NSData *)msgImage {
    if (_msgImage != msgImage) {
        _msgImage = msgImage;
        _msgContent = nil;
        _msgSound = nil;
    }
}

@end

@implementation DCDataCtrl_SendPublicNoMessage

- (void)dataRequest {
    if (self.param.user.token == nil) {
        return;
    }
    [self outputData];}

- (void)dataProcess:(NSData *)data {
    
}
@end
