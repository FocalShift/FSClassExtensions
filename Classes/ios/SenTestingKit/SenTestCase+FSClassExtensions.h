//
//  SenTestCase+FSClassExtensions.h
//  ObjectiveHAL
//
//  Created by Bennett Smith on 10/31/13.
//  Copyright (c) 2013 ObjectiveHAL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

@interface SenTestCase (FSClassExtensions)
- (void)prepareForAsyncTest;
- (void)signalAsyncTestCompleted;
- (BOOL)waitForAsyncTestCompletion:(NSTimeInterval)timeoutSecs;
@end
