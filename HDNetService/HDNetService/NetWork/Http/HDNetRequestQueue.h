//
//  HDNetRequestQueue.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HDNetRequest.h>

@class HDNetRequestQueue;

/**
 *  带队列的网络请求
 */
@interface HDNetQueuedRequest : HDNetRequest

/**
 *  队列
 */
@property (nonatomic,retain) HDNetRequestQueue *queue;
/**
 *  加入队尾
 */
@property (nonatomic,assign) bool tailQueue;

// subclass -  子类需要重写的内容

-(bool)queuedInProgress;	// 判断请求本身是否在进行中，子类重写此方法，而不要重写isInProgress
-(bool)queuedStart;			// 开始请求，子类应重写此方法，而不要重写start
-(void)queuedStop;			// 停止请求，子类应重写此方法，而不要重写stop

@end


@interface HDNetRequestQueue : NSObject

/**
 *  将请求加入队首
 *
 *  @param Request 要加入的请求对象
 */
-(void)pushRequest:(HDNetQueuedRequest*)Request;

/**
 *  将请求加入队尾
 *
 *  @param Request 要加入的请求对象
 */
-(void)enqueueRequest:(HDNetQueuedRequest*)Request;

/**
 *  移除请求
 *
 *  @param Request 要移除的请求对象
 *
 */
-(bool)removeRequest:(HDNetQueuedRequest*)Request;

/**
 *  判断请求是否在队列中
 *
 */
-(bool)isInQueue:(HDNetQueuedRequest*)Request;

/**
 *  最大同时请求的数量
 */
@property(nonatomic,assign) unsigned int maxParrielRequestCount;

/**
 *  由INetQueuedRequest调用，通知INetQueuedRequest下载已完成
 */
-(void)notifyRequestCompleted:(HDNetQueuedRequest*)Request;

@end
