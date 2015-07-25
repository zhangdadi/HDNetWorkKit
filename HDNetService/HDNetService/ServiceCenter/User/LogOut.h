//
//  LogOut.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_LogOut : HDNetServiceObject

@end

@interface DCData_LogOutParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@end

@interface DCDataCtrl_LogOut : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_LogOut      *data;
@property (nonatomic, strong, readonly) DCData_LogOutParam *param;
@end
