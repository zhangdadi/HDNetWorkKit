//
//  AttentionPublicList.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_AttentionPublicListInfo : NSObject
@property (nonatomic, assign) NSInteger pid; //公众号id
@property (nonatomic, strong) NSString *nickname; //公众号呢称
@property (nonatomic, strong) NSString *icon; //公众号头像url
@property (nonatomic, assign) NSInteger cid; //有关注关系的车id
@end

@interface DCData_AttentionPublicList : HDNetServiceObject
@property (nonatomic, strong) NSArray *attentionPublicListArray;
@end

@interface DCData_AttentionPublicListParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;//用户信息
@property (nonatomic, strong) NSString *fkey; //呢称搜索关键字
@property (nonatomic, assign) NSInteger pid; //公众号id
@end

/**
 *  已关注公众号列表请求类
 */
@interface DCDataCtrl_AttentionPublicList : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_AttentionPublicList *data;
@property (nonatomic, strong, readonly) DCData_AttentionPublicListParam *param;
@end

