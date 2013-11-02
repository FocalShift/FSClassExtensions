//
//  FSClassExtensionAsyncTestHandler.m
//  ObjectiveHAL
//
//  Created by Bennett Smith on 10/31/13.
//  Copyright (c) 2013 ObjectiveHAL. All rights reserved.
//

#import "FSClassExtensionAsyncTestHandler.h"
#import <objc/runtime.h>

static void *FSClassExtensionAsyncTestHandlerKey = &FSClassExtensionAsyncTestHandlerKey;

@implementation FSClassExtensionAsyncTestHandler

+ (FSClassExtensionAsyncTestHandler *)asyncTestHandlerForObject:(id)object {
    FSClassExtensionAsyncTestHandler *handler = objc_getAssociatedObject(object, FSClassExtensionAsyncTestHandlerKey);
    if (handler == nil) {
        handler = [[FSClassExtensionAsyncTestHandler alloc] init];
        objc_setAssociatedObject(object, FSClassExtensionAsyncTestHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return handler;
}

- (id)init {
    self = [super init];
    if (self) {
        _blockCompletionSemaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)prepareForAsyncTest {
    NSLog(@"*** PREPARING FOR ASYNC TEST ***");
    self.blockCompletionSemaphore = dispatch_semaphore_create(0);
}

- (void)signalAsyncTestCompleted {
    NSLog(@"*** SIGNALING ASYNC TEST COMPLETION ***");
    dispatch_semaphore_signal([self blockCompletionSemaphore]);
}

- (BOOL)waitForAsyncTestCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    BOOL successfulCompletion = YES;
    
    while (dispatch_semaphore_wait([self blockCompletionSemaphore], DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.125]];
        if([timeoutDate timeIntervalSinceNow] < 0.0) {
            NSLog(@"*** TIMEOUT WHILE WAITING FOR ASYNC TEST COMPLETION ***");
            successfulCompletion = NO;
            break;
        }
    }
    
    if (successfulCompletion == YES) {
        NSLog(@"*** RECEIVED SIGNAL FOR ASYNC TEST COMPLETION ***");
    }
    
    return successfulCompletion;
}

@end
