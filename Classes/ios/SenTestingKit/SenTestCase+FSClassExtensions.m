//
//  SenTestCase+FSClassExtensions.m
//  ObjectiveHAL
//
//  Created by Bennett Smith on 10/31/13.
//  Copyright (c) 2013 ObjectiveHAL. All rights reserved.
//

#import "SenTestCase+FSClassExtensions.h"
#import "FSClassExtensionAsyncTestHandler.h"

@implementation SenTestCase (FSClassExtensions)

- (void)prepareForAsyncTest {
    [[FSClassExtensionAsyncTestHandler asyncTestHandlerForObject:self] prepareForAsyncTest];
}

- (void)signalAsyncTestCompleted {
    [[FSClassExtensionAsyncTestHandler asyncTestHandlerForObject:self] signalAsyncTestCompleted];
}

- (BOOL)waitForAsyncTestCompletion:(NSTimeInterval)timeoutSecs {
    return [[FSClassExtensionAsyncTestHandler asyncTestHandlerForObject:self] waitForAsyncTestCompletion:timeoutSecs];
}

@end
