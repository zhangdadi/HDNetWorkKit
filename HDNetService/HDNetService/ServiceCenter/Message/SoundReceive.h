//
//  SoundReceive.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-8-15.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>


@interface DCData_SoundReceiveObj : HDNetServiceObject
@property (nonatomic, strong) NSData *content;
@end

@interface DCData_SoundReceiveParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString *msgAVLink;

@end

@interface DCDataCtrl_SoundReceive : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_SoundReceiveParam *param;
@property (nonatomic, strong, readonly) DCData_SoundReceiveObj *data;

@end

