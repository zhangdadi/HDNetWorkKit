//
//  ModifyUserInfo.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_ModifyUserInfo : HDNetServiceObject

@end

@interface DCData_ModifyUserInfoParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString  *nickname; //昵称
@property (nonatomic, strong) NSString  *email; //邮箱
@property (nonatomic, assign) NSInteger sex; //性别 1=男；2=女
@property (nonatomic, strong) NSString  *tel; //电话号码
@property (nonatomic, strong) NSData    *icon; //头像数据
@property (nonatomic, strong) NSString  *captcha; //验证码
@end

@interface DCDataCtrl_ModifyUserInfo : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_ModifyUserInfo      *data;
@property (nonatomic, strong, readonly) DCData_ModifyUserInfoParam *param;

@end
