//
//  HDNetRequestQueue.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDNetRequestQueue.h"
#include <vector>
#import "Debug.h"

using namespace iNetLib;

@implementation HDNetQueuedRequest
{
    // 正在排队中的队列
    HDNetRequestQueue *fProcessingQueue;
}

-(bool)isInProgress
{
    if(fProcessingQueue!=nil){
        if([fProcessingQueue isInQueue:self]){
            return true;
        }
    }
    return [self queuedInProgress];
}


-(bool)start
{
    if(_queue==nil)
        return [self queuedStart];
    if(_tailQueue){
        [_queue enqueueRequest:self];
    }
    else{
        [_queue pushRequest:self];
    }
    return true;
}

-(void)cancel
{
    if(fProcessingQueue!=nil){
        if([fProcessingQueue removeRequest:self])
            return;
    }
    if(self.isInProgress==false)
        return;
    [self queuedStop];
}


-(bool)queuedInProgress
{
    return false;
}

-(bool)queuedStart
{
    return false;
}
-(void)queuedStop
{
}

-(void)requestCompleted:(NSError*)error
{
    if(fProcessingQueue!=nil){
        [fProcessingQueue notifyRequestCompleted:self];
        fProcessingQueue=nil;
    }
    
    [super requestCompleted:error];
}

-(void)onRequestQueueEnter:(HDNetRequestQueue*)sender
{
    IN_ASSERT(fProcessingQueue==nil);
    
    fProcessingQueue=sender;
}
-(void)onRequestQueueLeave:(HDNetRequestQueue*)sender
{
    if(fProcessingQueue==sender){
        fProcessingQueue=nil;
    }
}


@end

@implementation HDNetRequestQueue
{
    std::vector<HDNetQueuedRequest*> RequestQueue;
    unsigned int RequestCount;
    unsigned int MaxParrielRequestCount;
}

-(id)init
{
    self=[super init];
    if(self==nil)
        return nil;
    
    MaxParrielRequestCount=1;
    return self;
}

-(void)notifyRequestCompleted:(HDNetQueuedRequest*)Request
{
    IN_ASSERT(RequestCount!=0);
    RequestCount--;
    [Request onRequestQueueLeave:self];
    [self continueProcessRequest];
}


-(void)doProcessRequest
{
    while(RequestCount<MaxParrielRequestCount){
        auto count=RequestQueue.size();
        if(count==0){
            // 没有等待中的请求
            return;
        }
        
        // 提取请求
        auto *Request=RequestQueue[count-1];
        RequestQueue.pop_back();
        
        // 开始
        if([Request queuedStart]){
            // 标记请求数
            RequestCount++;
        }
        else{
            // 请求失败
        }
    }
    
}

-(void)continueProcessRequest
{
    [self doProcessRequest];
}

-(void)pushRequest:(HDNetQueuedRequest*)Request
{
    IN_ASSERT(Request!=nullptr);
    IN_ASSERT(Request.isInProgress==false);
    
    // 从队列中删除
    bool Exists=[self internal_RemoveRequest:Request];
    // 重新加入队列
    RequestQueue.push_back(Request);
    if(Exists==false){
        // 通知请求对象：新加入队列
        [Request onRequestQueueEnter:self];
    }
    
    // 继续请求
    [self continueProcessRequest];
}

-(void)enqueueRequest:(HDNetQueuedRequest*)Request
{
    IN_ASSERT(Request!=nullptr);
    IN_ASSERT(Request.isInProgress==false);
    
    // 从队列中删除
    bool Exists=[self internal_RemoveRequest:Request];
    // 重新加入队列
    RequestQueue.insert(RequestQueue.begin(),Request);
    if(Exists==false){
        // 通知请求对象：新加入队列
        [Request onRequestQueueEnter:self];
    }
    // 继续请求
    
    [self continueProcessRequest];
}

-(bool)internal_RemoveRequest:(HDNetQueuedRequest*)Request
{
    if(Request==nullptr)
        return false;
    for(auto i=RequestQueue.begin();i<RequestQueue.end();i++){
        if(*i==Request){
            RequestQueue.erase(i);
            return true;
        }
    }
    return false;
}

-(bool)removeRequest:(HDNetQueuedRequest*)Request
{
    if([self internal_RemoveRequest:Request]){
        // 通知请求对象：退出队列
        [Request onRequestQueueLeave:self];
        return true;
    }
    return false;
}


-(bool)isInQueue:(HDNetQueuedRequest*)Request
{
    return find(RequestQueue.begin(),RequestQueue.end(),Request)!=RequestQueue.end();
}


@end
