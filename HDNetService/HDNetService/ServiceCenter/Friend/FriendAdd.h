//
//  FriendAdd.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_FriendAdd : HDNetServiceObject
@property (nonatomic, assign) NSInteger fid; //好友id
@property (nonatomic, strong) NSString *nickname; //昵称
@property (nonatomic, assign) NSInteger sex; //性别1=男；2=女
@property (nonatomic, strong) NSString *tel; //电话号码
@property (nonatomic, strong) NSString *email;//好友邮箱
@property (nonatomic, strong) NSString *icon; //头像url
@property (nonatomic, strong) NSString *username;//好友驾信号
@end

@interface DCData_FriendAddParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) NSInteger      fid; //添加的用户id
@end

@interface DCDataCtrl_FriendAdd : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_FriendAdd      *data;
@property (nonatomic, strong, readonly) DCData_FriendAddParam *param;
@end
