//
//  PublicList.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_PublicListInfo : NSObject
@property (nonatomic, assign) NSInteger pid; //公众号id
@property (nonatomic, strong) NSString *nickname; //公众号呢称
@property (nonatomic, strong) NSString *icon; //公众号头像url
@property (nonatomic, assign) NSInteger cid; //有关注关系的车id
@end

@interface DCData_PublicList : HDNetServiceObject
@property (nonatomic, strong) NSArray *publicListArray;

@end

/**
 *  公众号列表参数类
 */
@interface DCData_PublicListParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user; //用户信息
@property (nonatomic, assign) long cid; //车id
@property (nonatomic, strong) NSString *fkey; //呢称搜索关键字
@property (nonatomic, assign) NSInteger pid; //公众号id
@end

/**
 *  公众号列表请求类
 */
@interface DCDataCtrl_PublicList : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_PublicList *data;
@property (nonatomic, strong, readonly) DCData_PublicListParam *param;
@end
