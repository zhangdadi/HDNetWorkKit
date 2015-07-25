//
//  Feedback.h
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Feedback : HDNetServiceObject

@end

@interface DCData_FeedbackParam : NSObject
@property (nonatomic, strong) DriveCloudUser *user;
@property (nonatomic, assign) NSInteger      pid; //公众号id
@property (nonatomic, strong) NSString       *content; //反馈内容
@property (nonatomic, assign) NSInteger      type; //反馈类型

@end

/**
 *  发送反馈消息
 */
@interface DCDataCtrl_Feedback : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Feedback *data;
@property (nonatomic, strong, readonly) DCData_FeedbackParam *param;

@end
