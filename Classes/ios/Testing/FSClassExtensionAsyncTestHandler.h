//
//  FSClassExtensionAsyncTestHandler.h
//  ObjectiveHAL
//
//  Created by Bennett Smith on 10/31/13.
//  Copyright (c) 2013 ObjectiveHAL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSClassExtensionAsyncTestHandler : NSObject
@property (nonatomic, strong) dispatch_semaphore_t blockCompletionSemaphore;
+ (FSClassExtensionAsyncTestHandler *)asyncTestHandlerForObject:(id)object;
- (void)prepareForAsyncTest;
- (void)signalAsyncTestCompleted;
- (BOOL)waitForAsyncTestCompletion:(NSTimeInterval)timeoutSecs;
@end
