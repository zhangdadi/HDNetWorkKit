//
//  HDWebSocketManager.m
//  BDM
//
//  Created by 张达棣 on 14-10-28.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "HDWebSocketManager.h"
#import "SRWebSocket.h"
#import "HDMultiPointCallNode.h"
#import <Debug.h>
#import "HDMacro.h"

@interface HDWebSocketManager () <SRWebSocketDelegate>
{
    HDMultiPointCallNode *_callNode;
    NSURL *_url;
}

@end

@implementation HDWebSocketManager

#pragma mark - 生命周期
+ (instancetype)manager {
    static HDWebSocketManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _callNode = [[HDMultiPointCallNode alloc] init];
    }
    return self;
}

- (void)creatSocket {
    _socket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:KWebSocketUrl]];
    _socket.delegate = self;
    [_socket open];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    DebugLog(@"didReceiveMessage");
    [_callNode call:^(id data) {
        if (data && [data respondsToSelector:@selector(HDWebSocketManager:didReceiveMessage:)]) {
            [data HDWebSocketManager:self didReceiveMessage:message];
        }
    }];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    DebugLog(@"webSocketDidOpen");
    [_callNode call:^(id data) {
        if (data && [data respondsToSelector:@selector(HDWebSocketManagerDidOpen:)]) {
            [data HDWebSocketManagerDidOpen:self];
        }
    }];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    DebugLog(@"didFailWithError");
    [_callNode call:^(id data) {
        if (data && [data respondsToSelector:@selector(HDWebSocketManager:didFailWithError:)]) {
            [data HDWebSocketManager:self didFailWithError:error];
        }
    }];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    DebugLog(@"didCloseWithCode");
    [_callNode call:^(id data) {
        if (data && [data respondsToSelector:@selector(HDWebSocketManager:didCloseWithCode:reason:wasClean:)]) {
            [data HDWebSocketManager:self didCloseWithCode:code reason:reason wasClean:wasClean];
        }
    }];
}

#pragma mark -

- (void)setDelegate:(id<HDWebSocketManagerDelegate>)delegate {
    [_callNode addDelegate:delegate];
}

@end
