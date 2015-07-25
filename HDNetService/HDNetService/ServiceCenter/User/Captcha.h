//
//  Captcha.h
//  DriveCloudService
//
//  Created by 王夏林 on 14-7-23.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Captcha :HDNetServiceObject

@end

@interface DCData_CaptchaPatam : NSObject
@property (nonatomic, strong) NSString       *username; //用户名
@end

@interface DCDataCtrl_Captcha : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Captcha      *data;
@property (nonatomic, strong, readonly) DCData_CaptchaPatam *param;
@end