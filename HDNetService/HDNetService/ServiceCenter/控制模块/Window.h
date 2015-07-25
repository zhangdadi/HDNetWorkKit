//
//  Window.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Window : HDNetServiceObject
@property (nonatomic, strong)   NSString *cmd;
@property (nonatomic, assign)   NSInteger state;
@end

@interface DCData_WindowParam : HDParamParent
/**
 *  操作类型
 */
@property (nonatomic, assign) DCOperateType operateType;
/**
 *  持续时间
 */
@property (nonatomic, assign) int duration;
@end

/**
 *  车窗控制
 */
@interface DCDataCtrl_Window : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Window      *data;
@property (nonatomic, strong, readonly) DCData_WindowParam *param;

@end

