//
//  HDMultiPointCallNode.h
//  DriveCloudPhone
//
//  Created by 张达棣 on 14-8-11.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  不retain计数的多点回调
 */
@interface HDMultiPointCallNode : NSObject

/**
 *  把委托对象加入回调队列
 *
 *  @param delegate 委托对象
 */
- (void)addDelegate:(id)delegate;

/**
 *  从回调队列中移除委托对象
 *
 *  @param index 队列中的索引
 */
- (void)removeAtIndex:(NSInteger)index;

/**
 *  从回调队列中移除委托对象
 *
 *  @param delegate 委托对象
 */
- (void)removeDelegate:(id)delegate;

/**
 *  多点回调
 *
 *  @param block 回调的委托对象
 */
- (void)call:(void (^)(id delegate))block;

@end
