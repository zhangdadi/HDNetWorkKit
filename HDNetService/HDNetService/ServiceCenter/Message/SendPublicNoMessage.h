//
//  SendPublicNoMessage.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-19.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>


@interface DCData_SendPublicNoMessageObj : HDNetServiceObject
@property (nonatomic, assign) long long createdTime;
@property (nonatomic, assign) NSInteger mid;
@end

@interface DCData_SendPublicNoMessageParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString *pid; //发送的公众号id列表用,号分开
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, strong) NSData *msgSound;//语音
@property (nonatomic, strong) NSString *msgContent;//消息文本
@property (nonatomic, strong) NSData *msgImage;//图片

@end

@interface DCDataCtrl_SendPublicNoMessage : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_SendPublicNoMessageParam *param;
@property (nonatomic, strong, readonly) DCData_SendPublicNoMessageObj *data;

@end
