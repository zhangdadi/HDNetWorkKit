//
//  HDWebSocketManager.h
//  BDM
//
//  Created by 张达棣 on 14-10-28.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HDNetService/SRWebSocket.h>

@class HDWebSocketManager;

/**
 *  webSocket回调委托
 */
@protocol HDWebSocketManagerDelegate <NSObject>
/**
 *  收到数据时回调
 *
 *  @param webSocket 发起的websocket对象
 *  @param message   数据
 */
- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didReceiveMessage:(id)message;

@optional
/**
 *  webSocket连接成功时回调
 */
- (void)HDWebSocketManagerDidOpen:(HDWebSocketManager *)webSocket;
/**
 *  webSocket失败或者断开时回调
 */
- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didFailWithError:(NSError *)error;
/**
 *  webSocket断开时回调，从服务器断开
 */
- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;

@end


@interface HDWebSocketManager : NSObject
/**
 *  多点回调
 */
@property (nonatomic, weak) id<HDWebSocketManagerDelegate> delegate;
@property (nonatomic, strong, readonly) SRWebSocket *socket;

+ (instancetype)manager;
- (void)creatSocket;

@end
