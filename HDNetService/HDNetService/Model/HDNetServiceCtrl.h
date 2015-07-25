//
//  #import <HDNetService/HDNetServiceCtrl.h>
//  HDNetService
//
//  Created by 张达棣 on 14-11-5.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDParamParent.h"
#import "DriveCloudUser.h"

@class HDNetServiceCtrl, HDNetServiceObject, HDNetServiceCtrl;

typedef NS_ENUM(NSInteger, HDNetSerViceType) {
    
    HDNetSerViceTypeHttp = 0,
    HDNetSerViceTypeWebSocket,
    HDNetSerViceTypeBluetooth,
    HDNetSerViceTypeSocket,
};

/**
 *  回调界面的委托
 */
@protocol HDNetSerViceDelegate <NSObject>
@optional
- (void)HDNetSerViceUpdate:(HDNetServiceCtrl *)sender;
- (void)HDNetSerViceProgress:(HDNetServiceCtrl *)sender;
- (void)HDNetSerViceDidOpen:(HDNetServiceCtrl *)sneder type:(HDNetSerViceType)type;
- (void)HDNetSerViceDidFail:(HDNetServiceCtrl *)sneder type:(HDNetSerViceType)type;


@end

/**
 *  接口扩展类
 */
@interface HDNetServiceCtrl : NSObject

/**
 *  不保留计数的多点回调，当delegate对象被释放时会自动从回调队列中移除
 */
@property (nonatomic, weak) id<HDNetSerViceDelegate> delegate;

/**
 *  参数类
 */
@property (nonatomic, strong, readonly) NSObject  *param;

/**
 *  结果类
 */
@property (nonatomic, strong, readonly) HDNetServiceObject *data;

+ (instancetype)ctrl;

/**
 *  开始异步请求
 */
- (void)startAsynchronous;


#pragma mark - webSocket
/**
 *  打开webSocket连接
 */
- (void)openWebSocket;

/**
 *  关闭webSocket连接
 */
- (void)closeWebSocket;

@end

/**
 *  请求结果类
 */
@interface HDNetServiceObject : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, strong) NSString *error;
// 数据更新时间
@property(nonatomic,retain) NSDate *updateDate;


@end
