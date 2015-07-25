//
//  HDNetServiceCtrlExtend.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-5.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HDNetService/HDNetServiceCtrl.h>


@interface HDNetServiceCtrl()
/**
 *  子类重写，初始化请求
 */
- (void)dataRequest;
/**
 *  子类重写，请求完成后回调
 *
 *  @param data 服务器返回的数据
 */
- (void)dataProcess:(NSData *)data;

/**
 *  通知界面时调用
 */
- (void)outputData;

#pragma mark - webSocket
/**
 *  webSocket发送数据
 *
 *  @param data 要发送的数据
 */
- (void)webSocketRequest:(NSData *)data;

#pragma mark - HTTP
/**
 *  GET请求
 *
 *  @param urlSuffix  url后缀
 *  @param parameters 参数数组，类型为HDNetHTTPItem
 */
- (void)GET:(NSString *)urlSuffix parameters:(NSDictionary *)parameters;

/**
 *  POST请求
 *
 *  @param urlSuffix  url后缀
 *  @param parameters 参数数组，类型为HDNetHTTPItem
 */
- (void)POST:(NSString *)urlSuffix parameters:(NSDictionary *)parameters;



@end