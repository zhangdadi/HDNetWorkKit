//
//  Login.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Login : HDNetServiceObject
@property (nonatomic, strong)   NSString *token; //登录令牌
@property (nonatomic, assign)   NSInteger uid; //用户ID
@property (nonatomic, strong)   NSString *nickName;
@property (nonatomic, strong)   NSString *icon;
@end

@interface DCData_LoginParam : NSObject
@property (nonatomic, strong) NSString *username; //登录名
@property (nonatomic, strong) NSString *password; //密码
@end

@interface DCDataCtrl_Login : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Login      *data;
@property (nonatomic, strong, readonly) DCData_LoginParam *param;

@end
