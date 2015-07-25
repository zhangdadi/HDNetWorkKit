//
//  Combination.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Trunk : HDNetServiceObject
@property (nonatomic, strong)   NSString *cmd;
@property (nonatomic, assign)   int state;
@property (nonatomic, assign)   int winstate;
@property (nonatomic, assign)   int lockstate;
@property (nonatomic, assign)   int truckstate;
@end

@interface DCData_TrunkParam : HDParamParent
/**
 *  发动机操作类型
 */
@property (nonatomic, assign) DCOperateType engineOperateType;
/**
 *  发动机操作持续时间
 */
@property (nonatomic, assign) int engineDuration;

/**
 *  车窗操作类型
 */
@property (nonatomic, assign) DCOperateType windowOperateType;

/**
 *  车窗操作持续时间
 */
@property (nonatomic, assign) int windowDuration;

/**
 *  车门操作类型
 */
@property (nonatomic, assign) DCOperateType doorOperateType;

/**
 *  后备箱操作类型
 */
@property (nonatomic, assign) DCOperateType trunkOperateType;


@end

/**
 *  组合命令
 */
@interface DCDataCtrl_Trunk : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Trunk      *data;
@property (nonatomic, strong, readonly) DCData_TrunkParam *param;

@end
