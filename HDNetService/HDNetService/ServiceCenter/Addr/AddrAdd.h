//
//  AddrAdd.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-24.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_AddrAdd : HDNetServiceObject
@property (nonatomic, assign) NSInteger addrId;
@end

@interface DCData_AddrAddParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString *addr;//地址信息
@property (nonatomic, assign) float latitude;//纬度
@property (nonatomic, assign) float longitude;//经度
@property (nonatomic, strong) NSString *addrNote;//地址说明（如标题）
@property (nonatomic, assign) int addrFlag; //1=收藏；2=分享
@property (nonatomic, strong) NSString *fid; //好友id,多个时用","号隔开
@property (nonatomic, assign) long long shareTime; //分享时长（单位：分钟）（不提供，为永久分享）

@end

@interface DCDataCtrl_AddrAdd : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_AddrAdd *data;
@property (nonatomic, strong, readonly) DCData_AddrAddParam *param;

@end