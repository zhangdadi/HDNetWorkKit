//
//  UserInfo.h
//  yDriveData
//
//  Created by 张达棣 on 14-6-20.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>


@interface DCData_UserInfo : HDNetServiceObject
@property (nonatomic, assign) NSInteger uid; //用户ID
@property (nonatomic, strong) NSString  *userName; //登录名
@property (nonatomic, strong) NSString  *nickName; //昵称
@property (nonatomic, strong) NSString  *email; //邮箱
@property (nonatomic, assign) int sex; //性别 1=男；2=女
@property (nonatomic, strong) NSString  *tel; //电话号码
@property (nonatomic, strong) NSString  *icon; //头像url
@end

@interface DCData_UserInfoParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@end

@interface DCDataCtrl_UserInfo : HDNetServiceCtrl
@property (nonatomic, readonly) DCData_UserInfo *data;
@property (nonatomic, readonly) DCData_UserInfoParam *param;
@end
