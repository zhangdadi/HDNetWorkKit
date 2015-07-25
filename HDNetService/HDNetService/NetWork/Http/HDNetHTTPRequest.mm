//
//  HDNetHTTPRequest.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "HDNetHTTPRequest.h"
#import "Type.h"
#import "Debug.h"
#import "HDNetRequestQueue.h"
#import "HDNetActivityIndicator.h"
#import "HDNetHTTPItem.h"

using namespace iNetLib;

@interface HDNetHTTPItem ()
@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) id content;	// 数据内容，NSString或NSData
@property(nonatomic, strong) NSString *contentType;

@end


#pragma mark -

@interface HDNetHTTPRequest()<NSURLConnectionDataDelegate>

@end

@implementation HDNetHTTPRequest
{
    NSMutableURLRequest *fRequest;
    NSURLConnection *fConnection;
    NSHTTPURLResponse *fResponse;
    NSError *fError;
    bool HTTPInProgress;
    
    HDNetActivityIndicator *NetActIndicator;
    NSUInteger DownloadedSize;
    
    NSMutableData *DownloadingData;
    NSData *ResponseData;
}

@synthesize request=fRequest;
@synthesize response=fResponse;
@synthesize error=fError;
@synthesize destURL;
@synthesize completedSize=DownloadedSize;
@synthesize multipartDict;
@synthesize cached;

-(id)init
{
    self=[super init];
    if(self==nil)
        return nil;
    fRequest=[[NSMutableURLRequest alloc] init];
    fRequest.timeoutInterval=25;	// 超时时间
    fRequest.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
    
    NetActIndicator=[[HDNetActivityIndicator alloc]init];
    return self;
}

#pragma mark progress

static void DoClear(HDNetHTTPRequest *self)
{
    self->fResponse=nil;
    self->fConnection=nil;
}

-(bool)queuedInProgress
{
    return HTTPInProgress;
}

-(NSData *)responseData
{
    return ResponseData;
}

-(bool)queuedStart
{
    if(HTTPInProgress)
        return false;
    
    DoClear(self);
    fResponse=nil;
    HTTPInProgress=true;
    DownloadedSize=0;
    
    if (_methodType == HDHTTPMethodTypePOST) {
        [self creatPOSTParam];
    } else {
        [self creatGETParam];
    }
    [fRequest setURL:destURL];
    // 建立连接
    fConnection=[[NSURLConnection alloc]initWithRequest:fRequest delegate:self startImmediately:NO];
    [fConnection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [fConnection start];
    NetActIndicator.showNetActivityIndicator=true;
    //	IN_ASSERT(self.delegate!=nil);
    
    DebugLog(@"HTTP - %@\n",destURL.absoluteString);
    return true;
}

- (void)creatPOSTParam
{
    if(multipartDict==nil)
        return;
    if(multipartDict.count==0)
        return;
    
    //分界线的标识符
    constexpr static NSString *MPBoundary=@"0xKhTmLbOuNdArY";
    // body data
    NSMutableData *FormBody=[NSMutableData data];
    NSData *EndBoundaryData=[[[NSString alloc]initWithFormat:@"\r\n--%@--\r\n",MPBoundary] dataUsingEncoding:NSUTF8StringEncoding];
    
    // 文本字段
    for(NSString *Key in multipartDict) {
        HDNetHTTPItem *Item=multipartDict[Key];
        DebugLog(@"%@ - %@\n", Key, Item.content);
        NSMutableString *Header=[[NSMutableString alloc]init];
        
        //分界线
        [Header appendFormat:@"\r\n--%@\r\n",MPBoundary];
        //字段名称
        [Header appendFormat:@"Content-Disposition: form-data; name=\"%@\"",Key];
        if(Item.fileName!=nil && Item.content!=nil){
            [Header appendFormat:@"; filename=\"%@\"\r\n",Item.fileName];
        }
        else{
            [Header appendString:@"\r\n"];
        }
        //格式
        if(Item.contentType!=nil){
            [Header appendFormat:@"Content-Type: %@\r\n",Item.contentType];
        }
        // 编码
        if([Item.content isKindOfClass:[NSData class]]){
            [Header appendFormat:@"Content-Transfer-Encoding: binary\r\n"];
        }
        // 头结束
        [Header appendString:@"\r\n"];
        // 加入头
        [FormBody appendData:[Header dataUsingEncoding:NSUTF8StringEncoding]];
        // 加入数据
        if([Item.content isKindOfClass:[NSData class]]){
            NSData *data=Item.content;
            [FormBody appendData:data];
        }
        else{
            if(Item.content!=nil){
                auto text=[[NSString alloc]initWithFormat:@"%@",Item.content];
                [FormBody appendData:[text dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    //加入结束符
    [FormBody appendData:EndBoundaryData];
    
    //设置HTTPHeader中Content-Type的值
    NSString *ContentType=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",MPBoundary];
    //设置HTTPHeader
    [fRequest setValue:ContentType forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [fRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[FormBody length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    // FormBody开头多带了一个换行，http头不再添加
    [fRequest setHTTPBody:FormBody];
    //http method
    const NSArray *methodTypes = @[@"POST", @"GET"];
    fRequest.HTTPMethod = methodTypes[_methodType];
}

- (void)creatGETParam {
    if(multipartDict==nil)
        return;
    if(multipartDict.count==0)
        return;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@", destURL.absoluteString];
    BOOL isFirst = YES;
    for(NSString *key in multipartDict) {
        HDNetHTTPItem *item = multipartDict[key];
        if (isFirst) {
            isFirst = NO;
            [urlStr appendFormat:@"?%@=%@", key, item.content];
        } else {
            [urlStr appendFormat:@"&%@=%@", key, item.content];
        }
    }
    destURL = [NSURL URLWithString:urlStr];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    IN_ASSERT(connection==fConnection);
    
    fResponse=SafeCast<NSHTTPURLResponse>(response);
    
    // 获取下载的预期大小
    auto len=fResponse.expectedContentLength;
    if(len==NSURLResponseUnknownLength){
        len=0;
    }
    // 下载数据
    DownloadingData=[[NSMutableData alloc]initWithCapacity:static_cast<NSUInteger>(len)];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    IN_ASSERT(connection==fConnection);
    
    // 积累下载大小
    DownloadedSize+=data.length;
    [DownloadingData appendData:data];
    
    // 通知下载进度
    [self.delegate netRequestProgress:self];
}



// 下载完成
static void DoCompleted(HDNetHTTPRequest *self,NSError *error)
{
    // <下载中>标志
    self->HTTPInProgress=false;
    
    // 关闭网络下载指示
    self->NetActIndicator.showNetActivityIndicator=false;
    
#ifdef	DEBUG
    if(error==nil){
        // 模拟失败
        if(rand()%100<0){
            error=[[NSError alloc]initWithDomain:NSCocoaErrorDomain code:0 userInfo:nil];
        }
    }
#endif
    self->fError=error;
    
    auto Response=self->fResponse;
    
    self->cached=false;
    // 分析数据结束
    if(error==nil){
        if(Response.statusCode==304){
            // 缓存标志
            self->cached=true;
        }
    }
    else{
        DebugLog(@"HTTP *ERROR* - %@ : %@\n",self->destURL.absoluteString,error);
    }
    
    // 通知完成
    [self requestCompleted:error];
}

#ifdef	DEBUG
// 模拟延迟
-(void)delayComplete
{
    DoCompleted(self,nil);
}
#endif

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    IN_ASSERT(connection==fConnection);
    
    // 下载完成数据
    ResponseData=[DownloadingData copy];
    DownloadingData=nil;
    
#ifdef	DEBUG
    // 模拟延迟
    if(rand()%100<0){
        [self performSelector:@selector(delayComplete) withObject:nil afterDelay:3];
        return;
    }
#endif
    DoCompleted(self,nil);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    IN_ASSERT(connection==fConnection);
    
    DoCompleted(self,error);
}

#pragma mark control
-(void)queuedStop
{
    if(fConnection!=nil){
        [fConnection cancel];
        fConnection=nil;
        auto error=[[NSError alloc]initWithDomain:NSPOSIXErrorDomain code:EINTR userInfo:nil];
        DoCompleted(self,error);
    }
}

#pragma mark 进度信息

-(float)progressPercent
{
    auto len=fResponse.expectedContentLength;
    if(len==0)
        return 0;
    if(len==NSURLResponseUnknownLength)
        return 0.;
    return float(DownloadedSize)/len;
}

-(NSUInteger)expectedSize
{
    auto len=fResponse.expectedContentLength;
    if(len==NSURLResponseUnknownLength)
        return 0;
    return static_cast<NSUInteger>(len);
}

@end
