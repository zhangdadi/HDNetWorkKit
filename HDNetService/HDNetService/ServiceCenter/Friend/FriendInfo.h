//
//  FriendInfo.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_FriendInfo : HDNetServiceObject
@property (nonatomic, assign) NSInteger fid; //好友id
@property (nonatomic, strong) NSString *nickname; //好友呢称
@property (nonatomic, assign) NSInteger sex; //性别 1=男；2=女
@property (nonatomic, strong) NSString *tel; //好友电话号码
@property (nonatomic, strong) NSString *email; //好友邮箱
@property (nonatomic, strong) NSString *icon; //好友头像url
@property (nonatomic, strong) NSString *username;//好友驾信号
@end

@interface DCData_FriendInfoParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) NSInteger      fid; //好友id
@end

@interface DCDataCtrl_FriendInfo : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_FriendInfo      *data;
@property (nonatomic, strong, readonly) DCData_FriendInfoParam *param;
@end
