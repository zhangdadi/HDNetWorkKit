//
//  CarList.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-7-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//


#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_CarList : HDNetServiceObject
@property (nonatomic, strong) NSMutableArray *carListArray; //存放类型为DCData_CarListInfo

@end

@interface DCData_CarListInfo : NSObject
@property (nonatomic, assign) NSInteger keyid; //钥匙ID
@property (nonatomic, assign) NSInteger carid; //钥匙ID
@property (nonatomic, strong) NSString *chassis; //车驾号
@property (nonatomic, strong) NSString *blue; //蓝牙名
@property (nonatomic, strong) NSString *cartitle;
@property (nonatomic, strong) NSString *blueaddr;
@property (nonatomic, strong) NSString *deviceid;

@end

@interface DCData_CarListParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;

@end

@interface DCDataCtrl_CarList : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_CarList      *data;
@property (nonatomic, strong, readonly) DCData_CarListParam *param;

@end

