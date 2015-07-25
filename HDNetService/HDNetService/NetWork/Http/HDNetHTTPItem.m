//
//  HDNetHTTPItem.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-6.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDNetHTTPItem.h"

@interface HDNetHTTPItem ()
@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) id content;	// 数据内容，NSString或NSData
@property(nonatomic, strong) NSString *contentType;

@end

@implementation HDNetHTTPItem

+ (instancetype)itemPostValue:(NSObject *)value {
    HDNetHTTPItem *item =[ [HDNetHTTPItem alloc]init];
    item.contentType = @"text/plain";
    item.content = value.description;
    return item;
}

+ (instancetype)itemData:(NSData *)data {
    HDNetHTTPItem *item = [[HDNetHTTPItem alloc] init];
    item.contentType = @"application/octet-stream";
    item.content = data;
    return item;
}

+ (instancetype)itemData:(id)data withFileName:(NSString *)fileName {
    HDNetHTTPItem *item = [[HDNetHTTPItem alloc]init];
    item.contentType = @"application/octet-stream";
    item.content = data;
    item.fileName = fileName;
    return item;
}

@end

