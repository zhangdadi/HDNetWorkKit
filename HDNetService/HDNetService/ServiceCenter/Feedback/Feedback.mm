//
//  Feedback.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-6-25.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "Feedback.h"
#import "HDService.h"

using namespace iNetLib;

@implementation DCData_Feedback

@end

@implementation DCData_FeedbackParam

@end

@implementation DCDataCtrl_Feedback

- (void)dataRequest {
    [self outputData];
}

- (void)dataProcess:(NSData *)data {
    
}
@end
