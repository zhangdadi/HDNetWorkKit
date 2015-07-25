//
//  SignIn.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_SignIn : HDNetServiceObject
@property (nonatomic, strong) NSString  *token; //登录令牌
@property (nonatomic, assign)   NSInteger   uid;  //用户ID
@end

@interface DCData_SignInParam : NSObject
@property (nonatomic, strong) NSString  *username; //登录名
@property (nonatomic, strong) NSString  *password; //密码
@property (nonatomic, strong) NSString  *nickname; //昵称（不提供则为登录名）
@property (nonatomic, strong) NSString  *email; //邮箱
@property (nonatomic, assign) NSInteger sex; //性别 1=男；2=女
@property (nonatomic, strong) NSString  *tel; //电话号码
@end

@interface DCDataCtrl_SignIn : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_SignIn      *data;
@property (nonatomic, strong, readonly) DCData_SignInParam *param;

@end

