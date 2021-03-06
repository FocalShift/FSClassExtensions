//
// UIStoryboard+FSClassExtensions.m
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

#import "UIStoryboard+FSClassExtensions.h"

@implementation UIStoryboard (FSClassExtensions)

+ (UIStoryboard *)deviceSpecificStoryboardWithName:(NSString *)storyboardName bundle:(NSBundle *)storyboardBundleOrNil {
    NSString *deviceSpecificStoryboardName = nil;
    UIUserInterfaceIdiom uiIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (uiIdiom == UIUserInterfaceIdiomPad) {
        deviceSpecificStoryboardName = [NSString stringWithFormat:@"%@_iPad", storyboardName];
    }
    else if (uiIdiom == UIUserInterfaceIdiomPhone) {
        deviceSpecificStoryboardName = [NSString stringWithFormat:@"%@_iPhone", storyboardName];
    }
    else {
        deviceSpecificStoryboardName = storyboardName;
    }
    UIStoryboard *storyboard = nil;
    // When debugging, avoid unnecessary exceptions when changing storyboards;
    // the following creates too much exception "noise." First search for the
    // compiled storyboard within the bundle (main bundle by default) in debug
    // mode. The implementation assumes that the storyboard compiles to a file
    // with extension `storyboardc`.
#if DEBUG
    NSBundle *bundle = storyboardBundleOrNil ?: [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:deviceSpecificStoryboardName ofType:@"storyboardc"];
    storyboard = [UIStoryboard storyboardWithName:path ? deviceSpecificStoryboardName : storyboardName bundle:storyboardBundleOrNil];
#else
    @try {
        storyboard = [UIStoryboard storyboardWithName:deviceSpecificStoryboardName bundle:storyboardBundleOrNil];
    }
    @catch (NSException *exception) {
        storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:storyboardBundleOrNil];
    }
#endif
    return storyboard;
}

@end

