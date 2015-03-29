// NSDate+FSClassExtensions_Tests.m

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <FSClassExtensions/NSDate+FSClassExtensions.h>

@interface NSDate_FSClassExtensions_Tests : XCTestCase

@end

@implementation NSDate_FSClassExtensions_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreationOfTime {
    // given
    
    // when
    NSDate *date = [NSDate gmtDateWithHour:10 minute:32 second:18];

    // then
    XCTAssertNotNil(date);
}

@end
