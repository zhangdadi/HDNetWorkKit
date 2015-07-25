//
//  HDService.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-5.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDNetServiceCtrlExtend.h"
#import "Debug.h"
#import <HDNetHTTPRequest.h>
#import "HDNetHTTPItem.h"
#import "Type.h"
#import "Property.h"

@interface HDServiceWebSocket : NSObject

/**
 *  封装webSocket的包数据
 *
 *  @param cmdData    命令
 *  @param paramArray 参数列表，类型为NSData
 *
 *  @return 封装好的包
 */
+ (NSData *)packData:(NSData *)cmdData paramArray:(NSArray *)paramArray;

/**
 *  封装webSocket的包数据
 *
 *  @param cmdData    命令
 *  @param paramArray 参数列表，类型为NSData
 *  @param srcIDData  源ID
 *  @param dstIDData  目标ID
 *
 *  @return 封装好的包
 */
+ (NSData *)packData:(NSData *)cmdData paramArray:(NSArray *)paramArray srcID:(NSData *)srcIDData dstID:(NSData *)dstIDData;

/**
 *  解析数据,按报文格式把数据解析成一个个结果
 *
 *  @param data 要解析的数据
 *
 *  @return 解析好的数据列表
 */
+ (NSArray *)resData:(NSData *)data;

/**
 *  转换
 *
 *  @param obj 对象
 *
 *  @return 转换后的数据
 */
+ (NSData *)transform:(id)obj;

/**
 *  自动化解析赋值
 *
 *  @param cmdData  命令，用于识别接口
 *  @param retuData 请求返回的数据
 *  @param obj      要赋值的对象
 *  @param map      查询map
 *  @param finish   赋值完成时回调
 */
+ (void)evaluationCmdData:(NSData *)cmdData retuData:(NSData *)retuData obj:(HDNetServiceCtrl *)obj map:(NSDictionary *)map finsh:(void (^)())finish;

@end
