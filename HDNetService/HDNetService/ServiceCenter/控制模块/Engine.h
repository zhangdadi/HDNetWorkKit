//
//  Engine.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Engine : HDNetServiceObject
@property (nonatomic, strong)   NSString *cmd;
@property (nonatomic, assign)   NSInteger rev;
@end

@interface DCData_EngineParam : HDParamParent
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
 *  引擎控制
 */
@interface DCDataCtrl_Engine : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Engine      *data;
@property (nonatomic, strong, readonly) DCData_EngineParam *param;

@end

