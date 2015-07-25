//
//  HDNetActivityIndicator.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络进度提示，有任何对象标志为真时，显示网络进度指示
 */
@interface HDNetActivityIndicator : NSObject

/**
 *  显示网络进度提示
 */
@property (nonatomic, assign) BOOL showNetActivityIndicator;

@end
