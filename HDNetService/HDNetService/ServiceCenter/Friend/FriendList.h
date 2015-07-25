//
//  FriendList.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-24.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_FriendListInfo : NSObject
@property (nonatomic, assign) NSInteger fid; //好友id
@property (nonatomic, strong) NSString *nickname; //昵称
@property (nonatomic, strong) NSString *icon; //头像url
@property (nonatomic, assign) NSInteger sex; //性别 1=男；2=女
@property (nonatomic, strong) NSString  *tel; //电话号码
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) bool  isFriend;

@end

@interface DCData_FriendList : HDNetServiceObject
@property (nonatomic, strong) NSArray *friendArray;
@end

@interface DCData_FriendListParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, strong) NSString *fkey; //搜索关键字
@property (nonatomic, assign) int flag; //查询方式,0=所有人1=好友
@property (nonatomic, assign) int pageNumber; //页码
@end

@interface DCDataCtrl_FriendList : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_FriendList *data;
@property (nonatomic, strong, readonly) DCData_FriendListParam *param;
@end
