//
//  HDBluetoothManage.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-7.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDBluetoothManager;

@protocol HDBluetoothManagerDelegate <NSObject>

@optional

- (void)HDBluetoothManager:(HDBluetoothManager *)webSocket didReceiveMessage:(id)message;

- (void)HDBluetoothManagerDidOpen:(HDBluetoothManager *)webSocket;
- (void)HDBluetoothManager:(HDBluetoothManager *)webSocket didFailWithError:(NSError *)error;
- (void)HDBluetoothManager:(HDBluetoothManager *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;

@end


@interface HDBluetoothManager : NSObject
@property (nonatomic, weak) id<HDBluetoothManagerDelegate> delegate;
@property (nonatomic, assign) BOOL isConnectCar;
@property (nonatomic, assign) BOOL isConnectIng;

+ (instancetype)manager;

- (void)connect:(NSString *)name UUID:(NSString*)uuid;
- (void)Disconnect;
- (void)sendWithData:(NSData *)data;

@end
