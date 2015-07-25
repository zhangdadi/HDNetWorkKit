//
//  HDNetHTTPRequestManager.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-6.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDNetHTTPRequestManager.h"
#include <sys/sysctl.h>
#import "Debug.h"
#import "HDNetHTTPRequest.h"

#pragma mark - thread

@interface HDNetDataThread : NSThread<NSMachPortDelegate>
@end
@implementation HDNetDataThread
{
    NSMachPort *MsgPort;
}

-(id)init
{
    self=[super init];
    if(self==nil)
        return nil;
    MsgPort=[[NSMachPort alloc]init];
    [MsgPort setDelegate:self];
    [self start];
    return self;
}

-(void)main
{
    // 数据线程优先级调低（界面线程应该是0.5）
    [NSThread setThreadPriority:0.3];
    
    NSRunLoop *CurRunLoop=[NSRunLoop currentRunLoop];
    
    // Install the port as an input source on the current run loop.
    [CurRunLoop addPort:MsgPort forMode:NSDefaultRunLoopMode];
    
    [CurRunLoop runUntilDate:[NSDate distantFuture]];
}

-(void)handleMachMessage:(void *)msg
{
}

@end


static NSThread *gDataThreadInit(void) {
    size_t len;
    unsigned int ncpu=0;
    
    len = sizeof(ncpu);
    sysctlbyname ("hw.ncpu",&ncpu,&len,NULL,0);
    
    
    if(ncpu<=1){
        DebugLog(@"network in main thread\n");
        return [NSThread mainThread];
    }
    else{
        DebugLog(@"network multithreaded\n");
        return [[HDNetDataThread alloc]init];
    }
}

static NSThread *gDataThread = gDataThreadInit();
static HDNetRequestQueue *gMainQueue = [[HDNetRequestQueue alloc] init];


static bool IsDataThreadN(void){
    return [[NSThread currentThread] isEqual:gDataThread];
}

#pragma mark - HDNetHTTPRequestManager

@interface HDNetHTTPRequestManager ()<HDNetRequestDelegate>
{
    NSDictionary *_jsonDict;
    NSError *_jsonError;
}
@property (nonatomic, strong) HDNetHTTPRequest *netRequest;
@property (nonatomic, copy) HDNetProgressBlock progressBlock;
@property (nonatomic, copy) HDNetCompletionBlock completionBlock;
@end

@implementation HDNetHTTPRequestManager

#pragma mark - init

+ (instancetype)manager {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [self clearRequest];
}


- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(HDNetCompletionBlock)completion {
    self.completionBlock = completion;
    [self clearRequest];
    
    _netRequest = [[HDNetHTTPRequest alloc] init];
    _netRequest.destURL = [NSURL URLWithString:URLString];
    _netRequest.multipartDict = parameters;
    _netRequest.methodType = HDHTTPMethodTypeGET;
    [self startRequest];
}

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(HDNetCompletionBlock)completion {
    self.completionBlock = completion;
    [self clearRequest];
    
    _netRequest = [[HDNetHTTPRequest alloc] init];
    _netRequest.destURL = [NSURL URLWithString:URLString];
    _netRequest.multipartDict = parameters;
    [self startRequest];
}

- (void)setProgress:(HDNetProgressBlock)progress {
    self.progressBlock = progress;
}

#pragma mark - 

- (void)startRequest {
    _netRequest.queue = gMainQueue;
    if (!IsDataThreadN()) {
        [self performSelector:@selector(setupRequest) onThread:gDataThread withObject:nil waitUntilDone:NO];
    }
}


-(void)setupRequest {
    IN_ASSERT(IsDataThreadN());
    
    if (_netRequest != nil) {
        _netRequest.delegate = self;
        [_netRequest start];
    } else {
        // 通知不加载
        [self callUpdate];
    }

    // notify progress
    [self callProgress];
}

- (void)clearRequest {
    if (_netRequest != nil) {
        _netRequest.delegate = nil;
        [_netRequest cancel];
        _netRequest = nil;
    }
}

#pragma mark - HDNetRequestDelegate
// 有进度改变的通知
-(void)netRequestProgress:(HDNetRequest*)sender {
    [self callProgress];
}
// 请求完成的通知
-(void)netRequestCompletion:(HDNetRequest*)sender error:(NSError*)error {
    [self callUpdate];
}

#pragma mark - 通知
-(void)callUpdate {
//    NSError *error;
//    _jsonDict = [NSJSONSerialization JSONObjectWithData:_netRequest.responseData options:NSJSONReadingMutableLeaves error:&error];
//    _jsonError = error;
    [self performSelectorOnMainThread:@selector(mainThread_CallUpdate) withObject:nil waitUntilDone:YES];
}

-(void)callProgress {
    [self performSelectorOnMainThread:@selector(mainThread_CallProgress) withObject:nil waitUntilDone:YES];
}

-(void)mainThread_CallUpdate {
    if (_completionBlock) {
        _completionBlock(_netRequest.responseData, _netRequest.error);
    }
}

-(void)mainThread_CallProgress{
    if (_progressBlock) {
        _progressBlock(_netRequest.completedSize, _netRequest.expectedSize);
    }
}

#pragma mark -

@end
