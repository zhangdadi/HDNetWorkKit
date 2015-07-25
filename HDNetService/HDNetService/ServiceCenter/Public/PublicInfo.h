//
//  PublicInfo.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_PublicInfo : HDNetServiceObject
@property (nonatomic, assign) NSInteger pid; //公众号id
@property (nonatomic, strong) NSString *nickname; //公众号呢称
@property (nonatomic, strong) NSString *tel; //公众号电话号码
@property (nonatomic, strong) NSString *email; //公众号邮箱
@property (nonatomic, strong) NSString *icon; //公众号头像ur;
@property (nonatomic, assign) NSInteger cid; //车id（如果已被车关注）
@end


@interface DCData_PublicInfoParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) long  pid;
@property (nonatomic, assign) long  cid; //车id

@end

@interface DCDataCtrl_PublicInfo : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_PublicInfo *data;
@property (nonatomic, strong, readonly) DCData_PublicInfoParam *param;

@end