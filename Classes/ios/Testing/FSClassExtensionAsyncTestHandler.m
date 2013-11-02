//
//  FSClassExtensionAsyncTestHandler.m
//
// The MIT License (MIT)
// 
// Copyright (c) 2013 FocalShift
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
