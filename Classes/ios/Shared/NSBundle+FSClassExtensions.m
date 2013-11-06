//
// NSBundle+FSClassExtensions.m
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

#import <Foundation/Foundation.h>

@implementation NSBundle (FSClassExtensions)

// Original idea from http://stackoverflow.com/a/5860015/169363
// Modified to extend NSBundle in class category.
- (NSArray *)recursivePathsForResourcesOfType:(NSString *)type {
    NSString *directoryPath = [self bundlePath];
    NSMutableArray *filePaths = [NSMutableArray array];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:directoryPath];

    NSString *filePath;
    while ((filePath = [enumerator nextObject]) != nil) {
        // If we have the right type of file, add it to the list
        // Make sure to prepend the directory path
        if ([[filePath pathExtension] isEqualToString:type]) {
            NSString *resourcePath = [directoryPath stringByAppendingPathComponent:filePath];
            [filePaths addObject:resourcePath];
        }
    }
    return filePaths;
}

@end


