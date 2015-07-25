//
//  Door.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>

@interface DCData_Door : HDNetServiceObject
@property (nonatomic, strong)   NSString *cmd;
@property (nonatomic, assign)   NSInteger lock;
@property (nonatomic, assign)   NSInteger state;
@end

@interface DCData_DoorParam : HDParamParent
/**
 *  操作类型
 */
@property (nonatomic, assign) DCOperateType operateType;
@end

/**
 *  车门控制
 */
@interface DCDataCtrl_Door : HDNetServiceCtrl
@property (nonatomic, strong, readonly) DCData_Door      *data;
@property (nonatomic, strong, readonly) DCData_DoorParam *param;

@end

