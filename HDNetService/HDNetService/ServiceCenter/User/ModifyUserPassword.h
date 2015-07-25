//
//  ModifyUserPassword.h
//  DriveCloudService
//
//  Created by 王夏林 on 14-8-26.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_ModifyUserPassword : HDNetServiceObject

@end

@interface DCData_ModifyUserPasswordParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString *password;//原密码
@property (nonatomic, strong) NSString *password_new;//新密码

@end

@interface DCDataCtrl_ModifyUserPassword : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_ModifyUserPassword *data;
@property (nonatomic, strong, readonly) DCData_ModifyUserPasswordParam *param;
@end
