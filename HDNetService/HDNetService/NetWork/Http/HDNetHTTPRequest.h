//
//  HDNetHTTPRequest.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetRequestQueue.h>

/**
 *  http请求类型
 */
typedef NS_ENUM(int, HDHTTPMethodType) {
    /**
     *  POST请求
     */
    HDHTTPMethodTypePOST = 0,
    /**
     *  GET请求
     */
    HDHTTPMethodTypeGET,
};

/**
 *  http 请求
 */
@interface HDNetHTTPRequest : HDNetQueuedRequest

/**
 *  url
 */
@property(nonatomic,retain) NSURL *destURL;

/**
 *  请求类型，默认为POST请求
 */
@property (nonatomic, assign) HDHTTPMethodType methodType;

/**
 *  URLRequest对象
 */
@property(nonatomic,readonly) NSMutableURLRequest *request;

/**
 *  http请求的参数字典
 */
@property(nonatomic,retain) NSDictionary *multipartDict;

/**
 *  网络错误
 */
@property(nonatomic,readonly) NSError *error;

/**
 *  http返回对象
 */
@property(nonatomic,readonly) NSHTTPURLResponse *response;

/**
 *  是否有缓存
 */
@property(nonatomic,readonly) bool cached;

@end
