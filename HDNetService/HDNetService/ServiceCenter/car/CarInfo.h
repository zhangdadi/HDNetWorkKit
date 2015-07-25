//
//  CarInfo.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-28.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_CarInfoObj : HDNetServiceObject
@property (nonatomic, strong) NSString  *info;
@property (nonatomic, strong) NSString  *lat;
@property (nonatomic, strong) NSString  *lon;
@property (nonatomic, strong) NSString  *satellite;
@property (nonatomic, strong) NSString  *oilbox;
@property (nonatomic, strong) NSString  *oilbox_add;
@property (nonatomic, strong) NSString  *oilbox_add2;
@property (nonatomic, strong) NSString  *oilbox_add3;
@property (nonatomic, strong) NSString  *oilbox_add4;
@property (nonatomic, strong) NSString  *oilbox_sum;
@property (nonatomic, strong) NSString  *oilbox_sum_last;
@property (nonatomic, strong) NSString  *vol;
@property (nonatomic, strong) NSString  *tp_indoor;
@property (nonatomic, strong) NSString  *engine_rev;
@property (nonatomic, strong) NSString  *speed;
@property (nonatomic, strong) NSString  *update_time;
@property (nonatomic, strong) NSString  *mpi_oilsum;
@property (nonatomic, strong) NSString  *mpi_milesum;
@property (nonatomic, strong) NSString  *milestone;
@property (nonatomic, strong) NSString  *milestone_surplus;
@property (nonatomic, strong) NSString  *keys_num;

@end

@interface DCData_CarInfoParam : NSObject
@property (nonatomic, assign) NSInteger cid;

@end

@interface DCDataCtrl_CarInfo : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_CarInfoObj      *data;
@property (nonatomic, strong, readonly) DCData_CarInfoParam *param;

@end
