//
//  PublicAdd.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_PublicAdd : HDNetServiceObject

@end

@interface DCData_PublicAddParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user; //用户信息
@property (nonatomic, assign) NSInteger pid; //公众号id
@property (nonatomic, assign) NSInteger cid; //汽车id
@end

@interface DCDataCtrl_PublicAdd : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_PublicAdd *data;
@property (nonatomic, strong, readonly) DCData_PublicAddParam *param;
@end
