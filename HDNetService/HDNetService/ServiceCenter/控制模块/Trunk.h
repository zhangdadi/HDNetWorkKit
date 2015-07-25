//
//  Trunk.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Trunk : HDNetServiceObject
@property (nonatomic, strong)   NSString *cmd;
@property (nonatomic, assign)   NSInteger state;
@end

@interface DCData_TrunkParam : HDParamParent
/**
 *  操作类型
 */
@property (nonatomic, assign) DCOperateType operateType;
@end

/**
 *  后备箱控制
 */
@interface DCDataCtrl_Trunk : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Trunk      *data;
@property (nonatomic, strong, readonly) DCData_TrunkParam *param;

@end
