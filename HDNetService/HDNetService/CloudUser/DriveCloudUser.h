//
//  yDriveUser.h
//  yDriveData
//
//  Created by 张达棣 on 14-6-20.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCDataCtrl_UserInfo;
@class DCDataCtrl_LogOut;

@interface DriveCloudUser : NSObject

@property (nonatomic, strong) NSString *token; //token
@property (nonatomic, assign) int uid; //uid
@property (nonatomic, strong) NSString *username; //用户名
@property (nonatomic, strong) NSString *nickname; //用户呢称
@property (nonatomic, strong) NSString *iconUrl; //用户头像url
@property (nonatomic, assign) NSInteger sex; //性别 1=男；2=女
@property (nonatomic, strong) NSString  *tel; //电话号码

@property (nonatomic, readonly) DCDataCtrl_UserInfo *userInfoCtrl; //用户信息请求
@property (nonatomic, readonly) DCDataCtrl_LogOut   *logOutCtrl; //退出登录请求

@property (nonatomic, strong) NSString *lastUserName; //上一次登录的用户名

//退出登录设置空数据
- (void)setNoneData;

//请求用户信息成功时调用设置个人信息
- (void)setUserData;

@end
