//
//  BindingPhoneNum.h
//  DriveCloudService
//
//  Created by 王夏林 on 14-7-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_BindingPhoneNum : HDNetServiceObject

@end

@interface DCData_BindingPhoneNumParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString       *tel; //电话号码
@end

@interface DCDataCtrl_BindingPhoneNum : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_BindingPhoneNum      *data;
@property (nonatomic, strong, readonly) DCData_BindingPhoneNumParam *param;
@end