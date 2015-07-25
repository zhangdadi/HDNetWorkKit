//
//  HDNetHTTPItem.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-6.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>

// HTTP POST multiple part 数据字段
@interface HDNetHTTPItem : NSObject

/**
 *  设置value数据
 *
 *  @param value 数据内容
 */
+ (instancetype)itemPostValue:(NSObject *)value;

/**
 *  设置Data数据
 *
 *  @param value 数据内容
 */
+ (instancetype)itemData:(NSData *)data;

/**
 *  设置文件数据
 *
 *  @param data     文件内容
 *  @param fileName 文件名
 */
+ (instancetype)itemData:(id)data withFileName:(NSString *)fileName;

@end
