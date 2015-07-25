//
//  FriendDel.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_FriendDel : HDNetServiceObject

@end

@interface DCData_FriendDelParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) NSInteger      fid; //添加的用户id
@end

@interface DCDataCtrl_FriendDel : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_FriendDel      *data;
@property (nonatomic, strong, readonly) DCData_FriendDelParam *param;
@end