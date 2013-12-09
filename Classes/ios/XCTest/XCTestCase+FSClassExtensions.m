//
//  XCTestCase+FSClassExtensions.m
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

#import "XCTestCase+FSClassExtensions.h"
#import "FSClassExtensionAsyncTestHandler.h"

@implementation XCTestCase (FSClassExtensions)

// ****************************************************************************
#pragma mark - Testing Asynchronous Operations.
// ****************************************************************************

- (void)prepareForAsyncTest {
    [[FSClassExtensionAsyncTestHandler asyncTestHandlerForObject:self] prepareForAsyncTest];
}

- (void)signalAsyncTestCompleted {
    [[FSClassExtensionAsyncTestHandler asyncTestHandlerForObject:self] signalAsyncTestCompleted];
}

- (BOOL)waitForAsyncTestCompletion:(NSTimeInterval)timeoutSecs {
    return [[FSClassExtensionAsyncTestHandler asyncTestHandlerForObject:self] waitForAsyncTestCompletion:timeoutSecs];
}

// ****************************************************************************
#pragma mark - Reading JSON Test Data
// ****************************************************************************

- (id)jsonForTestFixture:(NSString *)fixtureName fromBundle:(NSBundle *)bundle {
    NSError *error = nil;
    NSString *fixturePath = [bundle pathForResource:fixtureName ofType:@"json"];
    NSData *fixtureData = [NSData dataWithContentsOfFile:fixturePath];
    id json = [NSJSONSerialization JSONObjectWithData:fixtureData options:0 error:&error];
    return json;
}

@end
