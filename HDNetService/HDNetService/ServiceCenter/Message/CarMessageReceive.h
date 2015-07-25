//
//  CarMessageReceive.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-12.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_CarMessageListInfo : NSObject
@property (nonatomic, assign) NSInteger senderId; //发送者id
@property (nonatomic, assign) NSInteger msgType; //消息类型，1=文本，2=语音 ,3=图片url
@property (nonatomic, strong) NSString *msgContent; //消息内容（文本或语音URL）
@property (nonatomic, assign) long long createdTime; //消息发送时间
@property (nonatomic, assign) NSInteger  isUserMessage; //1是用户消息，0是公众号消息
@property (nonatomic, assign) NSInteger cid; //车id
@property (nonatomic, assign) NSInteger mid;
@end

@interface DCData_CarMessageList : HDNetServiceObject
@property (nonatomic, strong) NSMutableArray *userMsgArray;
@property (nonatomic, strong) NSString *info;
@end

@interface DCData_CarMessageReceiveParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) long long receivedTime; //接受从这个时间开始的消息
@end

@interface DCDataCtrl_CarMessageReceive : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_CarMessageReceiveParam *param;
@property (nonatomic, strong, readonly) DCData_CarMessageList *data;

@end
