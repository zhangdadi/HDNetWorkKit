//
//  HDNetActivityIndicator.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDNetActivityIndicator.h"

@implementation HDNetActivityIndicator

-(void)dealloc
{
    // 停止显示
    self.showNetActivityIndicator = NO;
}

#pragma mark -

- (void)setShowNetActivityIndicator:(BOOL)showNetActivityIndicator
{
    if (_showNetActivityIndicator == showNetActivityIndicator)
        return;	// 标志无变化
    _showNetActivityIndicator = showNetActivityIndicator;
    if (showNetActivityIndicator) {
        // 增加显示引用
        if ([NSThread isMainThread])
            [HDNetActivityIndicator addShow];
        else
            [self performSelectorOnMainThread:@selector(callMainThreadAdd) withObject:nil waitUntilDone:NO];
    } else {
        // 减少显示引用
        if ([NSThread isMainThread])
            [HDNetActivityIndicator subShow];
        else
            [self performSelectorOnMainThread:@selector(callMainThreadSub) withObject:nil waitUntilDone:NO];
    }
}

- (void)callMainThreadAdd {
    [HDNetActivityIndicator addShow];
}

- (void)callMainThreadSub {
    [HDNetActivityIndicator subShow];
}

#pragma mark global

static int32_t NetActivityIndicatorVisibleCount = 0;	// 显示引用数
static NSTimer *NetActivityIndicatorTimer = nil;		// 延时消失定时器

+ (void)addShow {
    NetActivityIndicatorVisibleCount++;
    if (NetActivityIndicatorVisibleCount == 1) {
        // 显示
        UIApplication *app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = YES;
    }
}
+ (void)subShow {
    NetActivityIndicatorVisibleCount--;
    if (NetActivityIndicatorVisibleCount == 0) {
        // 延时隐藏
        if (NetActivityIndicatorTimer != nil){
            [NetActivityIndicatorTimer invalidate];
            NetActivityIndicatorTimer = nil;
        }
        NetActivityIndicatorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doShowNetActivityIndicator) userInfo:nil repeats:NO];
    }
}

+ (void)doShowNetActivityIndicator {
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NetActivityIndicatorVisibleCount != 0;
    NetActivityIndicatorTimer = nil;
}


@end
