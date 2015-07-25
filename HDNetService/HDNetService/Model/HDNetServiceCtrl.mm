//
//  HDNetServiceCtrl.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-5.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <HDNetService/HDNetServiceCtrl.h>
#import "Property.h"
#import "Debug.h"
#import <HDMultiPointCallNode.h>
#import "HDNetServiceCtrlExtend.h"
#import "HDWebSocketManager.h"
#import "HDNetActivityIndicator.h"
#import "HDNetHTTPRequestManager.h"

using namespace iNetLib;

struct ServerURLs
{
    NSString *base;
};


static const ServerURLs service_Public = {
    @"http://182.92.187.17/YHF/",
};

static const ServerURLs service_Test = {
    @"http://182.92.187.17/YHF/",
};

#if	DEBUG
#define	Server_Default	service_Test
#else
#define	Server_Default	service_Public
#endif

const ServerURLs *const gServerURLs=&Server_Default;


@interface HDNetServiceCtrl ()<HDWebSocketManagerDelegate>
{
    HDMultiPointCallNode *_callNode;
    HDNetActivityIndicator *_activityIndicato;
    HDNetHTTPRequestManager *_manager;
}
@property (nonatomic, strong) NSMutableArray *sendDataArray;
@end

@implementation HDNetServiceCtrl

#pragma mark - init
+ (instancetype)ctrl {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        Class ParamClass=[[self class] paramClass];
        Class dataClass=[[self class] dataClass];
        _param = [[ParamClass alloc] init];
        _data = [[dataClass alloc] init];
        
        [HDWebSocketManager manager].delegate = self;
        _callNode = [[HDMultiPointCallNode alloc] init];
        _activityIndicato = [[HDNetActivityIndicator alloc] init];
        _manager = [HDNetHTTPRequestManager manager];
    }
    return self;
}

- (void)dealloc {
    [_manager clearRequest];
}

- (void)startAsynchronous {
    self.data.error = nil;
    [self dataRequest];
}

- (void)setDelegate:(id<HDNetSerViceDelegate>)delegate {
    [_callNode addDelegate:delegate];
}

#pragma mark -

+ (Class)paramClass {
    OCPropertyInfo pInfo;
    
    if(pInfo.LoadClassProperty(self,"param")){
        // 从类型编码获取类型
        auto t=OCGetClassByTypeName(pInfo.type);
        if(t!=[NSObject class]){
            return t;
        }
    }
    // 找不到类型
    return [NSObject class];
}

+ (Class)dataClass {
    OCPropertyInfo pInfo;
    
    if(pInfo.LoadClassProperty(self,"data")){
        // 从类型编码获取类型
        auto t=OCGetClassByTypeName(pInfo.type);
        if(t!=[NSObject class]){
            return t;
        }
    }
    // 找不到类型
    return [NSObject class];
}

#pragma mark - 子类重写

- (void)dataRequest {
    IN_ASSERT(0);	//需要子类实现
}

- (void)dataProcess:(NSData *)data {
    IN_ASSERT(0);	//需要子类实现
}

#pragma mark - Http

- (void)GET:(NSString *)urlSuffix parameters:(NSDictionary *)parameters {
    Class dataClass=[[self class] dataClass];
    _data = [[dataClass alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@", gServerURLs->base, urlSuffix];
    
    [_manager GET:url parameters:parameters completion:^(id data, NSError *error) {
        if (error == nil) {
            [self dataProcess:data];
        } else {
            _data.error = error.localizedDescription;
        }
        [self outputData];
        
    }];
}

- (void)POST:(NSString *)urlSuffix parameters:(NSDictionary *)parameters {
    Class dataClass=[[self class] dataClass];
    _data = [[dataClass alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@", gServerURLs->base, urlSuffix];
    
    [_manager POST:url parameters:parameters completion:^(id data, NSError *error) {
        if (error == nil) {
            [self dataProcess:data];
        } else {
            _data.error = error.localizedDescription;
        }
        [self outputData];
    }];
}

#pragma mark - WebSOcket

- (void)openWebSocket {
    if ([HDWebSocketManager manager].socket.readyState != SR_OPEN) {
        [[HDWebSocketManager manager] creatSocket];
    }
}

- (void)closeWebSocket {
     [[HDWebSocketManager manager].socket close];
}

- (void)webSocketRequest:(NSData *)data {
    if ([HDWebSocketManager manager].socket.readyState == SR_OPEN) {
        DebugLog(@"发送:%@", data);
        [[HDWebSocketManager manager].socket send:data];
        self.sendDataArray = nil;
    } else {
        if (self.sendDataArray == nil || _sendDataArray.count == 0) {
            self.sendDataArray = [NSMutableArray arrayWithObject:data];
            [self openWebSocket];
        } else {
            [_sendDataArray addObject:data];
        }
    }
}


#pragma mark - HDWebSocketManagerDelegate

- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didReceiveMessage:(id)message {
    [self dataProcess:message];
}

- (void)HDWebSocketManagerDidOpen:(HDWebSocketManager *)webSocket {
    [_callNode call:^(id delegate) {
        if (delegate && [delegate respondsToSelector:@selector(HDNetSerViceDidOpen:type:)]) {
            [delegate HDNetSerViceDidOpen:self type:HDNetSerViceTypeWebSocket];
        }
    }];
    
    if (self.sendDataArray.count > 0) {
        for (NSData *data in _sendDataArray) {
            DebugLog(@"发送:%@", data);
            [[HDWebSocketManager manager].socket send:data];
        }
        self.sendDataArray = nil;
    }
}

- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didFailWithError:(NSError *)error {
    [_callNode call:^(id delegate) {
        if (delegate && [delegate respondsToSelector:@selector(HDNetSerViceDidFail:type:)]) {
            [delegate HDNetSerViceDidFail:self type:HDNetSerViceTypeWebSocket];
        }
    }];
    _data.error = @"连接不上服务器";
    self.sendDataArray = nil;
    [self outputData];
}

- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [_callNode call:^(id delegate) {
        if (delegate && [delegate respondsToSelector:@selector(HDNetSerViceDidFail:type:)]) {
            [delegate HDNetSerViceDidFail:self type:HDNetSerViceTypeWebSocket];
        }
    }];
    _data.error = @"连接不上服务器";
    self.sendDataArray = nil;
    [self outputData];
}

#pragma mark -

- (void)outputData {
    _activityIndicato.showNetActivityIndicator = NO;
    [_callNode call:^(id data) {
        if (data && [data respondsToSelector:@selector(HDNetSerViceUpdate:)]) {
            [data HDNetSerViceUpdate:self];
        }
    }];
}


@end


@implementation HDNetServiceObject


@end