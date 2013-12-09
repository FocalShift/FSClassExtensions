//
//  NSObject+FSClassExtensionsTests.m
//  FSClassExtensionsTestHarness
//
//  Created by Bennett Smith on 11/8/13.
//  Copyright (c) 2013 FocalShift, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <FSClassExtensions/NSObject+FSClassExtensions.h>

@interface NSObject_FSClassExtensionsTests : XCTestCase

@end

@implementation NSObject_FSClassExtensionsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

static void *relatedObjectKey = &relatedObjectKey;

- (void)testAssociatedObjectCreation {
    // Given
    NSObject *someObject = [[NSObject alloc] init];
    NSString *relatedObject = @"Related Object";
    
    // When
    [someObject associateValue:relatedObject withKey:relatedObjectKey];
    
    // Then
    id value = [someObject associatedValueForKey:relatedObjectKey];
    XCTAssertEqualObjects(relatedObject, value, @"Objects are not the same");
}

- (void)testDirtyFlag {
    // Given
    NSObject *someObject = [[NSObject alloc] init];
    
    // When
    [someObject setDirty:YES];
    
    // Then
    XCTAssertTrue([someObject isDirty], @"Object should be dirty.");
}

@end
