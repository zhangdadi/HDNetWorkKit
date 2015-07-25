//
//  AddrList.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_ShareListInfo : NSObject
@property (nonatomic, assign) NSInteger addrId; //分享地址id
@property (nonatomic, assign) float latitude;//纬度
@property (nonatomic, assign) float longitude;//经度
@property (nonatomic, strong) NSString *addrContent; //分享地址内容
@property (nonatomic, strong) NSString *addrNote; //分享地址说明
@property (nonatomic, assign) long long deadline; //分享截止时间
@end

@interface DCData_FavListInfo : NSObject
@property (nonatomic, assign) NSInteger addrId; //收藏地址id
@property (nonatomic, assign) float latitude;//经度
@property (nonatomic, assign) float longitude;//纬度
@property (nonatomic, strong) NSString *addrContent; //收藏地址内容
@property (nonatomic, strong) NSString *addrNote; //收藏地址说明
@end

@interface DCData_AddrList : HDNetServiceObject
@property (nonatomic, strong) NSArray *shareAddr;
@property (nonatomic, strong) NSArray *favAddr;
@end

@interface DCData_AddrListParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) long fid; //好友id

@end

@interface DCDataCtrl_AddrList : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_AddrList *data;
@property (nonatomic, strong, readonly) DCData_AddrListParam *param;
@end