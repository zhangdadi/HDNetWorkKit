//
//  AddMileage.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-28.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_AddMileageObj : HDNetServiceObject

@end

@interface DCData_AddMileageParam : NSObject
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger mileage; //保养路程
@end

@interface DCDataCtrl_AddMileage : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_AddMileageObj      *data;
@property (nonatomic, strong, readonly) DCData_AddMileageParam *param;

@end
