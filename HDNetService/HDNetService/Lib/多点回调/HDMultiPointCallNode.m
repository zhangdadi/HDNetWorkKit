//
//  HDMultiPointCallNode.m
//  DriveCloudPhone
//
//  Created by 张达棣 on 14-8-11.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "HDMultiPointCallNode.h"

@interface HDMultiPointCallNode ()
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) HDMultiPointCallNode *next;

@end

@implementation HDMultiPointCallNode

- (void)addDelegate:(id)delegate{
    [self removeDelegate:delegate];
    HDMultiPointCallNode *head = self;
    while (head.next != nil) {
        head = head.next;
    }
    
    HDMultiPointCallNode *newNode = [[HDMultiPointCallNode alloc] init];
    newNode.delegate                  = delegate;
    head.next                     = newNode;
}

- (void)removeDelegate:(id)delegate {
    HDMultiPointCallNode *head = self;
    HDMultiPointCallNode *temp = self.next;
    
    while (head.next != nil) {
        if (delegate == temp.delegate) {
            head.next = temp.next;
            temp.delegate = nil;
            temp      = nil;
        }
        head = head.next;
        temp = temp.next;
    }
}

- (void)removeAtIndex:(NSInteger)index {
    HDMultiPointCallNode *head = self;
    HDMultiPointCallNode *temp = self.next;
    
    for (int i = 0; head.next != nil && i <= index; ++i, head = head.next, temp = temp.next) {
        if (i == index) {
            head.next = temp.next;
            temp.delegate = nil;
            temp      = nil;
        }
    }
}

- (void)call:(void (^)(id delegate))block {
    HDMultiPointCallNode *head = self;
    
    for (int i = 0; head.next != nil; ++i) {
        head = head.next;
        if (head.delegate != nil) {
            block(head.delegate);
        } else {
            [self removeAtIndex:i--];
        }
    }
}

@end
