//
//  MessageReceive.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-7-28.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_MessageListInfo : NSObject
@property (nonatomic, assign) NSInteger senderId; //发送者id
@property (nonatomic, assign) NSInteger msgType; //消息类型，1=文本，2=语音 ,3=图片url
@property (nonatomic, strong) NSString *msgContent; //消息内容（文本或语音URL）
@property (nonatomic, assign) long long createdTime; //消息发送时间
@property (nonatomic, assign) NSInteger  isUserMessage; //1是用户消息，0是公众号消息
@property (nonatomic, assign) NSInteger cid; //车id
@property (nonatomic, assign) NSInteger mid;
@end

@interface DCData_MessageListObj : NSObject
@property (nonatomic, strong) NSMutableArray *userMsgArray;
@property (nonatomic, strong) NSMutableArray *publicNoMsgArray;

@end

@interface DCData_MessageReceiveParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) long long receivedTime; //接受从这个时间开始的消息
@end

@class DCDataCtrl_MessageReceive;
@protocol DCDataCtrl_MessageReceiveDelegate <NSObject>
- (void)DCDataCtrl_MessageReceive:(DCDataCtrl_MessageReceive *)sender;
- (void)DCDataCtrl_MessageReceiveConnetOff;
- (void)DCDataCtrl_MessageReceiveConnetSucceed;

@end

@interface DCDataCtrl_MessageReceive : NSObject
@property (nonatomic, strong, readonly) DCData_MessageReceiveParam *param;
@property (nonatomic, strong, readonly) DCData_MessageListObj *data;
@property (nonatomic, weak) id<DCDataCtrl_MessageReceiveDelegate> delegate;
- (void)start;
- (void)cancel;

@end
