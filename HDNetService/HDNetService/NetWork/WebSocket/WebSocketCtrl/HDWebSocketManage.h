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

@protocol HDWebSocketManagerDelegate <NSObject>

- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didReceiveMessage:(id)message;

@optional

- (void)HDWebSocketManagerDidOpen:(HDWebSocketManager *)webSocket;
- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didFailWithError:(NSError *)error;
- (void)HDWebSocketManager:(HDWebSocketManager *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;

@end


@interface HDWebSocketManager : NSObject

@property (nonatomic, weak) id<HDWebSocketManagerDelegate> delegate;
@property (nonatomic, strong, readonly) SRWebSocket *socket;

+ (instancetype)manager;
- (void)creatSocket;

@end
