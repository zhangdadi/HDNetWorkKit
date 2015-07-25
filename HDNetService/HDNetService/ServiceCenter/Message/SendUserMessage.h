//
//  SendUserMessage.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-14.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>


@interface DCData_SendUserMessageObj : HDNetServiceObject
@property (nonatomic, assign) long long createdTime;
@property (nonatomic, assign) NSInteger mid;
@end

@interface DCData_SendUserMessageParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString *fid; //发送的用户id列表用,号分开
@property (nonatomic, strong) NSData *msgSound;//语音
@property (nonatomic, strong) NSString *msgContent;//消息文本
@property (nonatomic, strong) NSData *msgImage;//图片

@end

@interface DCDataCtrl_SendUserMessage : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_SendUserMessageParam *param;
@property (nonatomic, strong, readonly) DCData_SendUserMessageObj *data;

@end
