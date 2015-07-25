//
//  HDParamParent.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-28.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>

//operate
typedef NS_ENUM(Byte, DCOperateType) {
    /**
     *  开始
     */
    DCOperateTypeStart = 0x0F,
    /**
     *  停止
     */
    DCOperateTypeStop = 0x00,
    /**
     *  切换
     */
    DCOperateTypeSwitch = 0x08
};

@interface HDParamParent : NSObject
/**
 *  源ID
 */
@property (nonatomic, strong) NSString *srcID;

/**
 *  目标ID
 */
@property (nonatomic, strong) NSString *dstID;
@end
