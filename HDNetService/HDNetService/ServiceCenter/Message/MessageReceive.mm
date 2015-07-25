//
//  MessageReceive.m
//  DriveCloudService
//
//  Created by 张达棣 on 14-7-28.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "MessageReceive.h"
#import "HDService.h"
#import "Debug.h"

#define NETWORK_STATUS   ([[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus] == NotReachable ? NO : YES)

using namespace iNetLib;


@implementation DCData_MessageListInfo

@end

@implementation DCData_MessageListObj

@end

@implementation DCData_MessageReceiveParam

@end

@interface DCDataCtrl_MessageReceive () <NSURLConnectionDataDelegate>
{
    NSMutableURLRequest *fRequest;
	NSURLConnection *fConnection;
	NSURLResponse *fResponse;
    
    BOOL _isConnection;
    
//    INInternetReachability *_reachability;
//    ocNotifyPointer _updateReachability;
 
}

@end

//static int afterConnectTime = 120 * 60;

@implementation DCDataCtrl_MessageReceive

- (id)init {
    self = [super init];
    if (self) {
        _param = [[DCData_MessageReceiveParam alloc] init];
        _data = [[DCData_MessageListObj alloc] init];
//        _reachability = [[INInternetReachability alloc] init];
//        _updateReachability[self] = @selector(MEreachabilityChanged);
//        _updateReachability.Receive(_reachability.onReachabilityChanged);
//        [_reachability startNotifier];
    }
    return self;
}

- (void)start {
//    if (!_reachability.internetReachable) {
//        return;
//    }
//    
//    fRequest=[[NSMutableURLRequest alloc]init];
//	fRequest.timeoutInterval=NSTimeIntervalSince1970;
//    if (_param.user.token == nil) {
//        return;
//    }
//    [fRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@msgcon?token=%@&lastmsgtime=%lld&ct=IOS&t=2", gServerURLs->base, self.param.user.token, self.param.receivedTime]]];
//	// 建立连接
//	fConnection=[[NSURLConnection alloc]initWithRequest:fRequest delegate:self startImmediately:NO];
//	[fConnection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//	[fConnection start];
//    DebugLog(@" %@", fRequest.URL);
//
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reconnect) object:nil];
//    [self performSelector:@selector(reconnect) withObject:nil afterDelay:afterConnectTime];
//    _isConnection = YES;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    fResponse = response;
    DebugLog(@"MessageReceive-didReceiveResponse");
    if (_delegate && [_delegate respondsToSelector:@selector(DCDataCtrl_MessageReceiveConnetSucceed)]) {
        [_delegate DCDataCtrl_MessageReceiveConnetSucceed];
    }
}

- (void)cancel {
    [fConnection cancel];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reconnect) object:nil];
//    [self performSelector:@selector(reconnect) withObject:nil afterDelay:afterConnectTime];
//
//    NSMutableData *data1 = (NSMutableData *)[@"<xml>" dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableData *data2 = (NSMutableData *)[@"</xml>" dataUsingEncoding:NSUTF8StringEncoding];
//    [data1 appendData:data];
//    [data1 appendData:data2];
//    data = data1;
//
//	auto obj = [[DCData_MessageListObj alloc] init];
//    obj.userMsgArray = [NSMutableArray array];
//    obj.publicNoMsgArray = [NSMutableArray array];
//    
//    NSDictionary *xmlDict = [data ZParserXML][@"xml"];
//    if (![xmlDict isKindOfClass:[NSDictionary class]]) {
//        return;
//    }
//    
//    NSDictionary *dict = xmlDict[@"root"];
//    DebugLog(@"%@", dict);
//    if ([dict isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < [dict count]; ++i) {
//            NSDictionary *rootDict = ((NSArray *)dict)[i];
//            [self voluation:rootDict obj:obj];
//        }
//    } else {
//        [self voluation:dict obj:obj];
//    }
//    _data = obj;
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(DCDataCtrl_MessageReceive:)]) {
//        [_delegate DCDataCtrl_MessageReceive:self];
//    }
//
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	DebugLog(@"MessageReceive-FinishLoading");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	DebugLog(@"MessageReceive-FailWithError");
    _isConnection = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(DCDataCtrl_MessageReceiveConnetOff)]) {
        [_delegate DCDataCtrl_MessageReceiveConnetOff];
    }
}


- (void)voluation:(NSDictionary *)rootDict obj:(DCData_MessageListObj *)obj {
//    id userMessageList = rootDict[@"userMsg"];
//    if ([userMessageList isKindOfClass:[NSArray class]]) {
//        NSArray *messageListArray = (NSArray *)userMessageList;
//        for (NSDictionary *item in messageListArray) {
//            DCData_MessageListInfo *info = [[DCData_MessageListInfo alloc] init];
//            info.senderId = OCDataCast<NSInteger>(item[@"senderId"]);
//            info.msgType = iNetLib::OCDataCast<NSInteger>(item[@"msgType"]);
//            info.msgContent = iNetLib::OCDataCast<NSString *>(item[@"msgContent"]);
//            info.createdTime = iNetLib::OCDataCast<long long>(item[@"createdTime"]);
//            info.mid = iNetLib::OCDataCast<long>(item[@"mid"]);
//            info.isUserMessage = 1;
//            
//            if (info.msgType == 3) {
//                if (info.msgContent != nil) {
//                    info.msgContent = [NSString stringWithFormat:@"%@%@", gServerURLs->base, info.msgContent];
//                };
//            }
//            
//            [obj.userMsgArray addObject:info];
//        }
//    } else if ([userMessageList isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *item = (NSDictionary *)userMessageList;
//        DCData_MessageListInfo *info = [[DCData_MessageListInfo alloc] init];
//        info.senderId = iNetLib::OCDataCast<NSInteger>(item[@"senderId"]);
//        info.msgType = iNetLib::OCDataCast<NSInteger>(item[@"msgType"]);
//        info.msgContent = iNetLib::OCDataCast<NSString *>(item[@"msgContent"]);
//        info.createdTime = iNetLib::OCDataCast<long long>(item[@"createdTime"]);
//        info.mid = iNetLib::OCDataCast<long>(item[@"mid"]);
//        info.isUserMessage = 1;
//        
//        if (info.msgType == 3) {
//            if (info.msgContent != nil) {
//                info.msgContent = [NSString stringWithFormat:@"%@%@", gServerURLs->base, info.msgContent];
//            };
//        }
//        
//        [obj.userMsgArray addObject:info];
//    }
//    
//    id publicMessageList = rootDict[@"publicNoMsg"];
//    if ([publicMessageList isKindOfClass:[NSArray class]]) {
//        NSArray *messageListArray = (NSArray *)publicMessageList;
//        for (NSDictionary *item in messageListArray) {
//            DCData_MessageListInfo *info = [[DCData_MessageListInfo alloc] init];
//            info.msgType = iNetLib::OCDataCast<NSInteger>(item[@"msgType"]);
//            if (info.msgType == 0) {
//                info.msgType = 1;
//            }
//            info.senderId = iNetLib::OCDataCast<NSInteger>(item[@"senderId"]);
//            info.msgContent = iNetLib::OCDataCast<NSString *>(item[@"msgContent"]);
//            info.createdTime = iNetLib::OCDataCast<long long>(item[@"createdTime"]);
//            info.cid = OCDataCast<NSInteger>(item[@"cid"]);
//            info.mid = iNetLib::OCDataCast<long>(item[@"mid"]);
//            info.isUserMessage = 0;
//            
//            if (info.msgType == 3) {
//                if (info.msgContent != nil) {
//                    info.msgContent = [NSString stringWithFormat:@"%@%@", gServerURLs->base, info.msgContent];
//                };
//            }
//            
//            [obj.publicNoMsgArray addObject:info];
//        }
//    } else if ([publicMessageList isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *item = (NSDictionary *)publicMessageList;
//        DCData_MessageListInfo *info = [[DCData_MessageListInfo alloc] init];
//        info.msgType = iNetLib::OCDataCast<NSInteger>(item[@"msgType"]);
//        if (info.msgType == 0) {
//            info.msgType = 1;
//        }
//        info.senderId = iNetLib::OCDataCast<NSInteger>(item[@"senderId"]);
//        info.msgContent = iNetLib::OCDataCast<NSString *>(item[@"msgContent"]);
//        info.createdTime = iNetLib::OCDataCast<long long>(item[@"createdTime"]);
//        info.cid = OCDataCast<NSInteger>(item[@"cid"]);
//        info.mid = iNetLib::OCDataCast<long>(item[@"mid"]);
//        info.isUserMessage = 0;
//        
//        if (info.msgType == 3) {
//            if (info.msgContent != nil) {
//                info.msgContent = [NSString stringWithFormat:@"%@%@", gServerURLs->base, info.msgContent];
//            };
//        }
//        
//        [obj.publicNoMsgArray addObject:info];
//    }
}

- (void)MEreachabilityChanged {
    
//    if (!_reachability.internetReachable) {
//        _isConnection = NO;
//        return;
//    }
//    if (_isConnection == NO) {
//        if (_delegate && [_delegate respondsToSelector:@selector(DCDataCtrl_MessageReceiveConnetOff)]) {
//            [_delegate DCDataCtrl_MessageReceiveConnetOff];
//        }
//    }
}

- (void)reconnect {
    if (_delegate && [_delegate respondsToSelector:@selector(DCDataCtrl_MessageReceiveConnetOff)]) {
        [_delegate DCDataCtrl_MessageReceiveConnetOff];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
