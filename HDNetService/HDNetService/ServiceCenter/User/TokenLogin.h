//
//  TokenLogin.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-10.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_LoginToken : HDNetServiceObject
@end

@interface DCData_LoginTokenParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@end

@interface DCDataCtrl_LoginToken : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_LoginToken      *data;
@property (nonatomic, strong, readonly) DCData_LoginTokenParam *param;

@end

