//
//  AddrfavDel.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_AddrfavDel : HDNetServiceObject

@end

@interface DCData_AddrfavDelParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) long addrId; //地址id

@end

@interface DCDataCtrl_AddrfaveDel : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_AddrfavDel *data;
@property (nonatomic, strong, readonly) DCData_AddrfavDelParam *param;

@end

