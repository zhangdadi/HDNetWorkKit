//
//  HDNetHTTPRequestManager.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-6.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDNetHTTPItem.h"

/**
 *  http请求完成后回调block，当请求成功时error为nil，否则相反。
 *
 *  @param data  数据，请求成功时有数据
 *  @param error 错误信息，请求成功时为空
 */
typedef void (^HDNetCompletionBlock)(id data, NSError *error);

/**
 *  http请求进度回调block
 *
 *  @param size  已下载的内容大小
 *  @param total 总的内容大小
 */
typedef void (^HDNetProgressBlock)(unsigned long long size, unsigned long long total);

@interface HDNetHTTPRequestManager : NSObject
+ (instancetype)manager;
/**
 *  清除请求，如果已在请求中就断开，如果不在请求中就从排队队列中移除
 */
- (void)clearRequest;

/**
 *  GET请求
 *
 *  @param URLString  请求的url地址
 *  @param parameters 参数数组，类型为HDNetHTTPItem
 *  @param completion 请求完成时回调block
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(HDNetCompletionBlock)completion;

/**
 *  POST请求
 *
 *  @param URLString  请求的url地址
 *  @param parameters 参数数组，类型为HDNetHTTPItem
 *  @param completion 请求完成时回调block
 */

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(HDNetCompletionBlock)completion;

/**
 *  设置进度回调，如果设置的progress则下载进度改变时就会回调
 *
 *  @param progress 回调block
 */
- (void)setProgress:(HDNetProgressBlock)progress;

@end
