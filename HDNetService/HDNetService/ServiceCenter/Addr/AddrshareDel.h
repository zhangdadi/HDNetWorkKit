//
//  AddrshareDel.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_AddrshareDel : HDNetServiceObject

@end

@interface DCData_AddrshareDelParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) long addrId; //地址id
@property (nonatomic, strong) NSString *fid; //分享的用户id,多个时用","号分开

@end

@interface DCDataCtrl_AddrShareDel : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_AddrshareDel *data;
@property (nonatomic, strong, readonly) DCData_AddrshareDelParam *param;

@end
