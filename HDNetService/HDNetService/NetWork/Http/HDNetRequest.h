//
//  HDNetRequest.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HDNetRequestDelegate;

@interface HDNetRequest : NSObject

// （网络请求回调）通知网络请求完毕
-(void)requestCompleted:(NSError*)error;

/**
 *  开始请求
 *
 *  @return YES请求成功，否则请求失败
 */
-(bool)start;

/**
 *  取消请求
 */
-(void)cancel;

/**
 *  请求是否在进行中
 */
@property(nonatomic,readonly) bool isInProgress;

/**
 *  通知
 */
@property (nonatomic, strong) id<HDNetRequestDelegate> delegate;

/**
 *  网络返回数据
 */
@property (nonatomic,readonly) NSData *responseData;

/**
 *  已下载的字节数
 */
@property(nonatomic,readonly) NSUInteger completedSize;

/**
 *  预期下载的字节数
 */
@property(nonatomic,readonly) NSUInteger expectedSize;

@end

@protocol HDNetRequestDelegate

/**
 *  有进度改变的通知
 */
-(void)netRequestProgress:(HDNetRequest*)sender;
/**
 *  请求完成的通知
 */
-(void)netRequestCompletion:(HDNetRequest*)sender error:(NSError*)error;

@end

