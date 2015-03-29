//
//  main.m
//  FSClassExtensions
//
//  Created by Bennett Smith on 07/08/2014.
//  Copyright (c) 2014 Bennett Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSAppDelegate.h"
#import "TestingAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        // Use a really simple AppDelegate when running unit tests.  Provides for
        // much faster app startup when running tests.  Also, you don't have to worry
        // about side effects from any normal app setup code found in the AppDelegate.
        
        BOOL isRunningTests = NSClassFromString(@"XCTestCase") != nil;
        Class appDelegateClass = isRunningTests ? [TestingAppDelegate class] : [FSAppDelegate class];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
    }
}
