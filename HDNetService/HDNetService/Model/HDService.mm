//
//  HDService.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-5.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDService.h"
#import "Debug.h"

using namespace iNetLib;

@implementation HDServiceWebSocket

+ (NSData *)packData:(NSData *)cmdData paramArray:(NSArray *)paramArray {
    Byte srcID[] = {0x00, 0x00, 0x00, 0x01}; //源ID
    Byte dstID[] = {0xff, 0xff, 0xff, 0xff}; //目标ID
    NSData *srcIDData = [NSData dataWithBytes:srcID length:sizeof(srcID)];
    NSData *dstIDData = [NSData dataWithBytes:dstID length:sizeof(dstID)];
    return [self packData:cmdData paramArray:paramArray srcID:srcIDData dstID:dstIDData];
}

+ (NSData *)packData:(NSData *)cmdData paramArray:(NSArray *)paramArray srcID:(NSData *)srcIDData dstID:(NSData *)dstIDData {
    DebugLog(@"请求命令:%@",cmdData);
    Byte role = 0x01;  //角色
    Byte flag[] = {0x00, 0x00}; //报文内容定义
    
    NSData *roleData = [NSData dataWithBytes:&role length:sizeof(role)];
    NSData *flagData = [NSData dataWithBytes:flag length:sizeof(flag)];
    
    NSMutableData *parckData = [NSMutableData data];
    [parckData appendData:cmdData];
    [parckData appendData:roleData];
    [parckData appendData:flagData];
    [parckData appendData:srcIDData];
    [parckData appendData:dstIDData];
    [parckData appendData:[self creatParamData:paramArray]];
    return [self startSendData:parckData];
}

+ (NSData *)creatParamData:(NSArray *)paramArray {
    NSMutableData *paramData = [NSMutableData data];
    
    UInt16 paramCount = paramArray.count;
    NSData *paramCountData = [NSData dataWithBytes:&paramCount length:sizeof(paramCount)];
    paramCountData = [self ConvertEnd:paramCountData];
    
    [paramData appendData:paramCountData]; //消息块个数
    
    for (NSData *data in paramArray) {
        UInt16 paramLen = 0;
        if (![data isKindOfClass:[NSNull class]] && data.length > 0) {
            paramLen = data.length;
        }
        DebugLog(@"参数长度:%4x,数据:%@", paramLen, data);
        NSData *paramLenData = [NSData dataWithBytes:&paramLen length:sizeof(paramLen)];
        paramLenData = [self ConvertEnd:paramLenData];
        [paramData appendData:paramLenData];
        if (paramLen > 0) {
            [paramData appendData:data];
        }
    }
    return paramData;
}

+ (NSData *)startSendData:(NSData *)parckData {
    Byte head[] = {0xfa, 0xfb}; //包头
    Byte tait[] = {0xbf, 0xaf}; //包尾
    
    UInt32 packetLen = (UInt32)parckData.length;
    NSData *packetLenData = [NSData dataWithBytes:&packetLen length:sizeof(packetLen)];
    packetLenData = [self ConvertEnd:packetLenData];
    NSData *headData = [NSData dataWithBytes:head length:sizeof(head)];
    NSData *taitData = [NSData dataWithBytes:tait length:sizeof(tait)];
    
    NSMutableData *allData = [NSMutableData data];
    [allData appendData:headData];
    [allData appendData:packetLenData];
    [allData appendData:parckData];
    [allData appendData:taitData];
    return allData;
}

#pragma mark - 小端换大端，大端换小端
+ (NSData *)ConvertEnd:(NSData *)data {
    const Byte *content = (const Byte *)[data bytes];
    NSInteger len = data.length;
    NSMutableData *retuData = [NSMutableData data];
    for (NSInteger i = len - 1; i >= 0; --i) {
        Byte byte = content[i];
        [retuData appendBytes:&byte length:1];
    }
    return retuData;
}

#pragma mark - 解析数据
+ (NSArray *)resData:(NSData *)data {
    NSUInteger loction = 21;
    if (data.length < loction + 2) {
        return nil;
    }
    NSData *parCount = [data subdataWithRange:NSMakeRange(loction, 2)]; //消息块个数
    loction += 2;
    
    Byte bui[2] = {0x00, 0x00};
    [parCount getBytes:bui];
    
    long long count = [self stringFromHexString:parCount.description];
    NSMutableArray *retuArray = [NSMutableArray arrayWithCapacity:(NSUInteger)count + 1];
    [retuArray addObject:[data subdataWithRange:NSMakeRange(6, 4)]];
    
    for (int i = 0; i < count; i++) {
        NSData *itemLenData = [data subdataWithRange:NSMakeRange(loction, 2)];
        loction += 2;
        long long itemLen = [self stringFromHexString:itemLenData.description];
        if (data.length < loction + itemLen) {
            return nil;
        }
        NSData *itemData = [data subdataWithRange:NSMakeRange(loction, (NSUInteger)itemLen)];
        loction += itemLen;
        [retuArray addObject:itemData];
    }
    return retuArray;
}

// 十六进制转换为十进制。
+ (long long)stringFromHexString:(NSString *)hexString {
    NSDictionary *haxDict = @{@"0":@"0", @"1":@"1", @"2":@"2", @"3":@"3", @"4":@"4", @"5":@"5", @"6":@"6", @"7":@"7", @"8":@"8", @"9":@"9", @"a":@"10", @"b":@"11", @"c":@"12", @"d":@"13", @"e":@"14", @"f":@"15"};
    
    NSString *str = [hexString substringWithRange:NSMakeRange(1, hexString.length - 2)];
    long long sum = 0;
    for (int i = (int)str.length - 1, j = 0; i >= 0; --i, j++) {
        NSString *itemStr = [str substringWithRange:NSMakeRange(i, 1)];
        long long itemInt = [haxDict[itemStr] longLongValue];
        sum += (itemInt * pow(16, j));
    }
    return sum;
}

+ (NSData *)transform:(id)obj {
    id data;
    if (obj == nil) {
        data = [NSNull null];
    } else if ([obj isKindOfClass:[NSData class]]) {
        data = obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        data = [obj dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        data = [[obj description] dataUsingEncoding:NSUTF8StringEncoding];
    }
    return data;
}

+ (void)evaluationCmdData:(NSData *)cmdData retuData:(NSData *)retuData obj:(HDNetServiceCtrl *)obj map:(NSDictionary *)map finsh:(void (^)())finish {
    NSArray *array = [HDServiceWebSocket resData:retuData];
    if (![cmdData isEqualToData:array[0]]) {
        return;
    }
    if (array.count < 3) {
        DebugLog(@"%@", array);
        if ([[array[1] description] isEqualToString:@"<00>"]) {
            obj.data.error = nil;
        } else {
            obj.data.error = @"请求错误";
        }
        [obj outputData];
        return;
    }
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:array[2] options:NSJSONReadingMutableLeaves error:nil];
    DebugLog(@"%@", rootDict);
    OCDataTransfer(obj.data, map, rootDict);
    if (finish) {
        finish();
    }
    [obj outputData];
}



@end
